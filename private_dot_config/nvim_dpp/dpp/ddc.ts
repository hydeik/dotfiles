import { BaseConfig } from "jsr:@shougo/ddc-vim@~6.0.0/types";
import { ConfigArguments } from "jsr:@shougo/ddc-vim@~6.0.0/config";

import * as fn from "jsr:@denops/std@~7.0.1/function";

export class Config extends BaseConfig {
    override async config(args: ConfigArguments): Promise<void> {
        const commonSources = ["around", "file"];

        args.contextBuilder.patchGlobal({
            ui: "pum",
            sources: commonSources,
            autoCompleteEvents: [
                "CmdlineChanged",
                "CmdlineEnter",
                "InsertEnter",
                "TextChangedI",
                "TextChangedP",
                "TextChangedT",
            ],
            cmdlineSources: {
                ":": ["cmdline", "cmdline-history", "around"],
                "@": ["cmdline-history", "input", "file", "around"],
                ">": ["cmdline-history", "input", "file", "around"],
                "/": ["around", "line"],
                "?": ["around", "line"],
                "-": ["around", "line"],
                "=": ["input"],
            },
            sourceOptions: {
                _: {
                    ignoreCase: true,
                    matchers: ["matcher_fuzzy"],
                    sorters: ["sorter_fuzzy"],
                    converters: ["converter_fuzzy"],
                    timeout: 1000,
                },
                around: {
                    mark: "A",
                },
                buffer: {
                    mark: "B",
                },
                vim: {
                    mark: "vim",
                    isVolatile: true,
                },
                cmdline: {
                    mark: "cmdline",
                    forceCompletionPattern: "\\S/\\S*|\\.\\w*",
                },
                // copilot: {
                //     mark: "cop",
                //     matchers: [],
                //     minAutoCompleteLength: 0,
                //     isVolatile: false,
                // },
                // codeium: {
                //     mark: "cod",
                //     matchers: ["matcher_length"],
                //     minAutoCompleteLength: 0,
                //     isVolatile: true,
                // },
                input: {
                    mark: "input",
                    forceCompletionPattern: "\\S/\\S*",
                    isVolatile: true,
                },
                line: {
                    mark: "line",
                },
                // mocword: {
                //     mark: "mocword",
                //     minAutoCompleteLength: 4,
                //     isVolatile: true,
                // },
                lsp: {
                    mark: "lsp",
                    forceCompletionPattern: "\\.\\w*|::\\w*|->\\w*",
                    dup: "force",
                },
                // rtags: {
                //     mark: "R",
                //     forceCompletionPattern: "\\.\\w*|::\\w*|->\\w*",
                // },
                file: {
                    mark: "F",
                    isVolatile: true,
                    minAutoCompleteLength: 1000,
                    forceCompletionPattern: "\\S/\\S*",
                },
                "cmdline-history": {
                    mark: "history",
                    sorters: [],
                },
                "shell-history": {
                    mark: "history",
                },
                shell: {
                    mark: "sh",
                    isVolatile: true,
                    forceCompletionPattern: "\\S/\\S*",
                },
                "shell-native": {
                    mark: "sh",
                    isVolatile: true,
                    forceCompletionPattern: "\\S/\\S*",
                },
                rg: {
                    mark: "rg",
                    minAutoCompleteLength: 5,
                    enabledIf: "finddir('.git', ';') != ''",
                },
                // skkeleton: {
                //     mark: "skk",
                //     matchers: [],
                //     sorters: [],
                //     minAutoCompleteLength: 2,
                //     isVolatile: true,
                // },
                yank: {
                    mark: "Y",
                },
            },
            sourceParams: {
                buffer: {
                    requireSameFiletype: false,
                    limitBytes: 50000,
                    fromAltBuf: true,
                    forceCollect: true,
                },
                file: {
                    filenameChars: "[:keyword:].",
                },
                lsp: {
                    enableDisplayDetail: true,
                },
                "shell-native": {
                    shell: "fish",
                },
            },
            postFilters: ["sorter_head"],
        });
    }
}
