import {
    BaseConfig,
    type ConfigReturn,
    type ContextBuilder,
    type Dpp,
    type MultipleHook,
    type Plugin,
} from "jsr:@shougo/dpp-vim@~1.1.0/types";
import { mergeFtplugins } from "jsr:@shougo/dpp-vim@~1.1.0/utils";

import { Denops } from "jsr:@denops/std@~7.0.1";
import * as fn from "jsr:@denops/std@~7.0.1/function";
import { expandGlob } from "jsr:@std/fs/expand-glob";
import { join } from "jsr:@std/path/join";

type Toml = {
    hooks_file?: string;
    ftplugins?: Record<string, string>;
    multiple_hooks?: MultipleHook[];
    plugins?: Plugin[];
};

type LazyMakeStateResult = {
    plugins: Plugin[];
    stateLines: string[];
};

export class Config extends BaseConfig {
    override async config(args: {
        denops: Denops;
        contextBuilder: ContextBuilder;
        basePath: string;
        dpp: Dpp;
    }): Promise<ConfigReturn> {
        const vimConfigDir = Deno.env.get("VIM_CONFIG_DIR") as string;
        const dppConfigDir = join(vimConfigDir, "dpp");
        const luaConfigDir = join(vimConfigDir, "lua", "rc");

        const inlineVimrcs = [
            join(luaConfigDir, "disable_builtin.lua"),
            join(luaConfigDir, "options.lua"),
            join(luaConfigDir, "keymaps.lua"),
            join(luaConfigDir, "autocmds.lua"),
        ];

        args.contextBuilder.setGlobal({
            inlineVimrcs,
            extParams: {
                installer: {
                    checkDiff: true,
                    logFilePath: join(
                        Deno.env.get("VIM_DATA_DIR"),
                        "dpp",
                        "installer-log.txt",
                    ),
                    githubAPIToken: Deno.env.get("GITHUB_API_TOKEN"),
                    maxProcesses: 10,
                },
            },
            protocols: ["git"],
        });

        const [context, options] = await args.contextBuilder.get(args.denops);

        // --- load plugins listed in toml files
        const tomlPromises = [
            { path: join(dppConfigDir, "dpp.toml"), lazy: false },
            { path: join(dppConfigDir, "denops.toml"), lazy: true },
            { path: join(dppConfigDir, "plugins_start.toml"), lazy: false },
            { path: join(dppConfigDir, "plugins_lazy.toml"), lazy: true },
        ].map(
            (tomlFile) =>
                args.dpp.extAction(
                    args.denops,
                    context,
                    options,
                    "toml",
                    "load",
                    {
                        path: tomlFile.path,
                        options: {
                            lazy: tomlFile.lazy,
                        },
                    },
                ) as Promise<Toml | undefined>,
        );
        const tomls: (Toml | undefined)[] = await Promise.all(tomlPromises);

        // Merge toml results
        const recordPlugins: Record<string, Plugin> = {};
        const ftplugins: Record<string, string> = {};
        const hooksFiles: string[] = [];
        let multipleHooks: MultipleHook[] = [];
        for (const toml of tomls) {
            if (!toml) {
                continue;
            }

            for (const plugin of toml.plugins ?? []) {
                recordPlugins[plugin.name] = plugin;
            }

            if (toml.ftplugins) {
                mergeFtplugins(ftplugins, toml.ftplugins);
            }

            if (toml.multiple_hooks) {
                multipleHooks = multipleHooks.concat(toml.multiple_hooks);
            }

            if (toml.hooks_file) {
                hooksFiles.push(toml.hooks_file);
            }
        }

        // --- Load local plugins
        const localPlugins = (await args.dpp.extAction(
            args.denops,
            context,
            options,
            "local",
            "local",
            {
                directory: "~/work",
                options: {
                    frozen: true,
                    merged: false,
                },
                includes: [
                    "vim*",
                    "nvim-*",
                    "*.vim",
                    "*.nvim",
                    "ddc-*",
                    "ddu-*",
                    "dpp-*",
                    "skkeleton",
                    "neco-vim",
                ],
            },
        )) as Plugin[] | undefined;

        if (localPlugins) {
            for (const plugin of localPlugins) {
                if (plugin.name in recordPlugins) {
                    recordPlugins[plugin.name] = Object.assign(
                        recordPlugins[plugin.name],
                        plugin,
                    );
                } else {
                    recordPlugins[plugin.name] = plugin;
                }
            }
        }

        // --- Load packspec plugins
        const packSpecPlugins = (await args.dpp.extAction(
            args.denops,
            context,
            options,
            "packspec",
            "load",
            {
                basePath: args.basePath,
                plugins: Object.values(recordPlugins),
            },
        )) as Plugin[] | undefined;
        if (packSpecPlugins) {
            for (const plugin of packSpecPlugins) {
                if (plugin.name in recordPlugins) {
                    recordPlugins[plugin.name] = Object.assign(
                        recordPlugins[plugin.name],
                        plugin,
                    );
                } else {
                    recordPlugins[plugin.name] = plugin;
                }
            }
        }

        const lazyResult = (await args.dpp.extAction(
            args.denops,
            context,
            options,
            "lazy",
            "makeState",
            {
                plugins: Object.values(recordPlugins),
            },
        )) as LazyMakeStateResult | undefined;

        const checkFiles = [];
        for await (const file of expandGlob(`${dppConfigDir}/*`)) {
            checkFiles.push(file.path);
        }

        return {
            checkFiles,
            ftplugins,
            hooksFiles,
            multipleHooks,
            plugins: lazyResult?.plugins ?? [],
            stateLines: lazyResult?.stateLines ?? [],
        };
    }
}
