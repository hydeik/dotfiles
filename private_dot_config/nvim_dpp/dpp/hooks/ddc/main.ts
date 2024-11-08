import { BaseConfig, ConfigArguments } from "jsr:@shougo/ddc-vim@~8.1.0/config";
import { type DdcItem } from "jsr:@shougo/ddc-vim@~8.1.0/types";

import type { Denops } from "jsr:@denops/std";
import * as fn from "jsr:@denops/std/function";

export class Config extends BaseConfig {
  override config(args: ConfigArguments): Promise<void> {
    const commonSources = ["lsp", "around", "file"];
    const denops = args.denops;

    args.contextBuilder.patchGlobal({
      ui: "pum",
      dynamicUi: async (denops: Denops, args: Record<string, unknown>) => {
        const uiArgs = args as { items: DdcItem[] };
        const mode = await fn.mode(denops);
        return Promise.resolve(
          mode !== "t" && uiArgs.items.length == 1 ? "inline" : "pum",
        );
      },
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
          // timeout: 1000,
        },
        around: {
          mark: "A",
        },
        buffer: {
          mark: "B",
        },
        cmdline: {
          mark: "cmdline",
          forceCompletionPattern: "\\S/\\S*|\\.\\w*",
        },
        "cmdline-history": {
          mark: "history",
          sorters: [],
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
        file: {
          mark: "F",
          isVolatile: true,
          minAutoCompleteLength: 1000,
          forceCompletionPattern: "\\S/\\S*",
        },
        input: {
          mark: "input",
          forceCompletionPattern: "\\S/\\S*",
          isVolatile: true,
        },
        line: {
          mark: "line",
        },
        lsp: {
          mark: "LSP",
          forceCompletionPattern: "\\.|:\\s*|->\\s*",
          dup: "keep",
          sorters: ["sorter_lsp-kind", "converter_kind_labels"],
        },
        "nvim-lua": {
          mark: "lua",
          dup: "keep",
          forceCompletionPattern: "\\.\\w*",
        },
        rg: {
          mark: "rg",
          minAutoCompleteLength: 5,
          enabledIf: "finddir('.git', ';') != ''",
        },
        shell: {
          mark: "sh",
          isVolatile: true,
          forceCompletionPattern: "\\S/\\S*",
        },
        "shell-history": {
          mark: "history",
        },
        "shell-native": {
          mark: "sh",
          isVolatile: true,
          forceCompletionPattern: "\\S/\\S*",
        },
        // skkeleton: {
        //     mark: "skk",
        //     matchers: [],
        //     sorters: [],
        //     minAutoCompleteLength: 2,
        //     isVolatile: true,
        // },
        vim: {
          mark: "vim",
          isVolatile: true,
        },
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
          // enableDisplayDetail: true,
          enableResolveItem: true,
          enableAdditionalTextEdit: true,
          confirmBehavior: "replace",
          snippetEngine: async (body: string) => {
            await denops.call("denippet#anonymous", body);
          },
        },
        "shell-native": {
          shell: "zsh",
        },
      },
      filterParams: {
        "sorter_lsp-kind": {
          priority: [
            "Snippet",
            "Method",
            "Function",
            "Constructor",
            "Field",
            "Variable",
            "Class",
            "Interface",
            "Module",
            "Property",
            "Unit",
            "Value",
            "Enum",
            "Keyword",
            "Color",
            "File",
            "Reference",
            "Folder",
            "EnumMember",
            "Constant",
            "Struct",
            "Event",
            "Operator",
            "TypeParameter",
            "Text",
          ],
        },
        converter_kind_labels: {
          kindLabels: {
            Text: " Text",
            Method: " Method",
            Function: " Function",
            Constructor: " Constructor",
            Field: " Field",
            Variable: " Variable",
            Class: " Class",
            Interface: " Interface",
            Module: " Module",
            Property: " Property",
            Unit: " Unit",
            Value: " Value",
            Enum: " Enum",
            Keyword: "K eyword",
            Snippet: " Snippet",
            Color: " Color",
            File: " File",
            Reference: "' Reference",
            Folder: " Folder",
            EnumMember: " EnumMember",
            Constant: " Conjkustant",
            Struct: " Struct",
            Event: " Event",
            Operator: " Operator",
            TypeParameter: " TypeParameter",
          },
          kindHlGroups: {
            Text: "String",
            Method: "Function",
            Function: "Function",
            Constructor: "Function",
            Field: "Identifier",
            Variable: "Identifier",
            Class: "Structure",
            Interface: "Structure",
            Module: "Function",
            Property: "Identifier",
            Unit: "Identifier",
            Value: "String",
            Enum: "Structure",
            Keyword: "Identifier",
            Snippet: "Structure",
            Color: "Structure",
            File: "Structure",
            Reference: "Function",
            Folder: "Structure",
            EnumMember: "Structure",
            Constant: "String",
            Struct: "Structure",
            Event: "Function",
            Operator: "Identifier",
            TypeParameter: "Identifier",
          },
        },
      },
      // postFilters: ["sorter_head"],
    });

    for (const filetype of ["html", "css"]) {
      args.contextBuilder.patchFiletype(filetype, {
        sourceOptions: {
          _: {
            keywordPattern: "[0-9a-zA-Z_:#-]*",
          },
        },
      });
    }

    for (const filetype of ["zsh", "sh", "bash"]) {
      args.contextBuilder.patchFiletype(filetype, {
        sourceOptions: {
          _: {
            keywordPattern: "[0-9a-zA-Z_./#:-]*",
          },
        },
        sources: ["shell-native", "around"],
      });
    }

    // Use "#" as TypeScript keywordPattern
    for (const filetype of ["typescript"]) {
      args.contextBuilder.patchFiletype(filetype, {
        sourceOptions: {
          _: {
            keywordPattern: "#?[a-zA-Z_][0-9a-zA-Z_]*",
          },
        },
      });
    }

    args.contextBuilder.patchFiletype("lua", {
      sources: ["nvim-lua", ...commonSources],
    });

    args.contextBuilder.patchFiletype("vim", {
      sources: ["vim", ...commonSources],
    });

    return Promise.resolve();
  }
}
