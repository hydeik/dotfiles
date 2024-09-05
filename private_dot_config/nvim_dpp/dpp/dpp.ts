import {
    type ContextBuilder,
    type ExtOptions,
    type MultipleHook,
    type Plugin,
} from "jsr:@shougo/dpp-vim@~3.0.0-pre2/types";
import {
    BaseConfig,
    type ConfigReturn,
} from "jsr:@shougo/dpp-vim@~3.0.0-pre2/config";
import { mergeFtplugins } from "jsr:@shougo/dpp-vim@~3.0.0-pre2/utils";

import type {
    Ext as LazyExt,
    LazyMakeStateResult,
    Params as LazyParams,
} from "jsr:@shougo/dpp-ext-lazy@~1.4.0";
import type {
    Ext as LocalExt,
    Params as LocalParams,
} from "jsr:@shougo/dpp-ext-local@~1.2.0";
import type {
    Ext as PackspecExt,
    Params as PackspecParams,
} from "jsr:@shougo/dpp-ext-packspec@~1.2.0";
import type {
    Ext as TomlExt,
    Params as TomlParams,
    Toml,
} from "jsr:@shougo/dpp-ext-toml@~1.2.0";

import { Denops } from "jsr:@denops/std@~7.1.0";
import { expandGlob } from "jsr:@std/fs/expand-glob";
import { join } from "jsr:@std/path/join";

export class Config extends BaseConfig {
    override async config(args: {
        denops: Denops;
        contextBuilder: ContextBuilder;
        basePath: string;
    }): Promise<ConfigReturn> {
        const dppConfigDir = Deno.env.get("DPP_CONFIG_DIR") as string;
        const dppBaseDir = Deno.env.get("DPP_BASE_DIR") as string;
        const luaConfigDir = join(dppConfigDir, "rc");

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
                        dppBaseDir,
                        "installer-log.txt",
                    ),
                    githubAPIToken: Deno.env.get("GITHUB_API_TOKEN"),
                    maxProcesses: 10,
                },
            },
            protocols: ["git"],
        });

        const [context, options] = await args.contextBuilder.get(args.denops);
        const protocols = await args.denops.dispatcher.getProtocols();

        // --- load plugins listed in toml files
        const recordPlugins: Record<string, Plugin> = {};
        const ftplugins: Record<string, string> = {};
        const hooksFiles: string[] = [];
        let multipleHooks: MultipleHook[] = [];

        const [tomlExt, tomlOptions, tomlParams]: [
            TomlExt | undefined,
            ExtOptions,
            TomlParams,
        ] = await args.denops.dispatcher.getExt(
            "toml",
        ) as [TomlExt | undefined, ExtOptions, TomlParams];
        if (tomlExt) {
            const action = (tomlExt as TomlExt).actions["load"];

            const tomlPromises = [
                { path: join(dppConfigDir, "dpp.toml"), lazy: false },
                { path: join(dppConfigDir, "denops.toml"), lazy: true },
                { path: join(dppConfigDir, "plugins_start.toml"), lazy: false },
                { path: join(dppConfigDir, "plugins_lazy.toml"), lazy: true },
                { path: join(dppConfigDir, "ddc.toml"), lazy: true },
                { path: join(dppConfigDir, "ddu.toml"), lazy: true },
            ].map((tomlFile) =>
                action.callback({
                    denops: args.denops,
                    context,
                    options,
                    protocols,
                    extOptions: tomlOptions,
                    extParams: tomlParams,
                    actionParams: {
                        path: tomlFile.path,
                        options: {
                            lazy: tomlFile.lazy,
                        },
                    },
                })
            );
            const tomls = await Promise.all(
                tomlPromises,
            ) as (Toml | undefined)[];
            // Merge toml results
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
        }

        // --- Load local plugins
        const [localExt, localOptions, localParams]: [
            LocalExt | undefined,
            ExtOptions,
            LocalParams,
        ] = await args.denops.dispatcher.getExt(
            "local",
        ) as [LocalExt | undefined, ExtOptions, LocalParams];
        if (localExt) {
            const action = localExt.actions["local"];

            const localPlugins = await action.callback({
                denops: args.denops,
                context,
                options,
                protocols,
                extOptions: localOptions,
                extParams: localParams,
                actionParams: {
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
                    ],
                },
            }) as Plugin[];

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
        }

        // --- Load packspec plugins
        const [packspecExt, packspecOptions, packspecParams]: [
            PackspecExt | undefined,
            ExtOptions,
            PackspecParams,
        ] = await args.denops.dispatcher.getExt(
            "packspec",
        ) as [PackspecExt | undefined, ExtOptions, PackspecParams];
        if (packspecExt) {
            const action = packspecExt.actions["load"];

            const packSpecPlugins = await action.callback({
                denops: args.denops,
                context,
                options,
                protocols,
                extOptions: packspecOptions,
                extParams: packspecParams,
                actionParams: {
                    basePath: args.basePath,
                    plugins: Object.values(recordPlugins),
                },
            }) as Plugin[];
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
        }

        // --- Lazy load settings
        const [lazyExt, lazyOptions, lazyParams]: [
            LazyExt | undefined,
            ExtOptions,
            LazyParams,
        ] = await args.denops.dispatcher.getExt(
            "lazy",
        ) as [LazyExt | undefined, ExtOptions, PackspecParams];
        let lazyResult: LazyMakeStateResult | undefined = undefined;
        if (lazyExt) {
            const action = lazyExt.actions.makeState;

            lazyResult = await action.callback({
                denops: args.denops,
                context,
                options,
                protocols,
                extOptions: lazyOptions,
                extParams: lazyParams,
                actionParams: {
                    plugins: Object.values(recordPlugins),
                },
            }) as LazyMakeStateResult;
        }

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
