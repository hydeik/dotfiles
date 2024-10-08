import {
  type ActionArguments,
  ActionFlags,
  type DduOptions,
} from "jsr:@shougo/ddu-vim@~6.1.0/types";

import {
  BaseConfig,
  type ConfigArguments,
} from "jsr:@shougo/ddu-vim@~6.1.0/config";

import { type ActionData as FileAction } from "jsr:@shougo/ddu-kind-file@~0.9.0";
import { type Params as FfParams } from "jsr:@shougo/ddu-ui-ff@~1.4.0";
import { type Params as FilerParams } from "jsr:@shougo/ddu-ui-filer@~1.4.0";

import type { Denops } from "jsr:@denops/std@~7.1.0";
import * as fn from "jsr:@denops/std@~7.1.0/function";

type Params = Record<string, unknown>;

type DppAction = {
  path: string;
  __name: string;
};

export class Config extends BaseConfig {
  override config(args: ConfigArguments): Promise<void> {
    args.setAlias("source", "file_rg", "file_external");
    args.setAlias("source", "file_git", "file_external");
    args.setAlias(
      "filter",
      "matcher_ignore_current_buffer",
      "matcher_ignores",
    );
    args.setAlias("action", "tabopen", "open");

    args.contextBuilder.patchGlobal({
      ui: "ff",
      profile: false,
      uiOptions: {
        ff: {
          actions: {
            kensaku: async (args: {
              denops: Denops;
              options: DduOptions;
            }) => {
              await args.denops.dispatcher.updateOptions(
                args.options.name,
                {
                  sourceOptions: {
                    _: {
                      matchers: ["matcher_kensaku"],
                    },
                  },
                },
              );
              await args.denops.cmd(
                "echomsg 'change to kensaku matcher'",
              );

              return ActionFlags.Persist;
            },
          },
        },
        filer: {
          toggle: true,
        },
      },
      uiParams: {
        ff: {
          autoAction: {
            name: "preview",
          },
          floatingBorder: "single",
          floatingTitle: "Results",
          floatingTitlePos: "center",
          ignoreEmpty: true,
          inputFunc: "cmdline#input",
          previewFloating: true,
          previewFloatingBorder: "single",
          previewSplit: "vertical",
          previewFloatingTitle: "Preview",
          previewFloatingTitlePos: "center",
          previewWindowOptions: [
            ["&signcolumn", "no"],
            ["&foldcolumn", 0],
            ["&foldenable", 0],
            ["&number", 0],
            ["&wrap", 0],
            ["&scrolloff", 0],
          ],
          prompt: "",
          split: "floating",
          startAutoAction: true,
        } as Partial<FfParams>,
        filer: {
          previewFloating: true,
          sort: "filename",
          sortTreesFirst: true,
          split: "no",
          toggle: true,
        } as Partial<FilerParams>,
      },
      sourceOptions: {
        _: {
          ignoreCase: true,
          matchers: ["matcher_substring"],
          smartCase: true,
        },
        buffer: {
          converters: ["converter_hl_dir"],
          columns: ["icon_filename"],
        },
        file_old: {
          matchers: [
            "matcher_relative",
            "matcher_substring",
          ],
          converters: ["converter_hl_dir"],
          columns: ["icon_filename"],
        },
        file_git: {
          matchers: [
            "matcher_relative",
            "matcher_substring",
          ],
          sorters: ["sorter_mtime"],
          converters: ["converter_hl_dir"],
          columns: ["icon_filename"],
        },
        file_rec: {
          matchers: [
            "matcher_substring",
            "matcher_hidden",
          ],
          sorters: ["sorter_mtime"],
          converters: [
            "converter_hl_dir",
          ],
          columns: ["icon_filename"],
        },
        file_fd: {
          matchers: [
            "matcher_substring",
            "matcher_hidden",
          ],
          converters: ["converter_hl_dir"],
          columns: ["icon_filename"],
        },
        file_rg: {
          matchers: [
            "matcher_substring",
            "matcher_hidden",
          ],
          converters: ["converter_hl_dir"],
          columns: ["icon_filename"],
        },
        file: {
          matchers: [
            "matcher_substring",
            "matcher_hidden",
          ],
          sorters: ["sorter_alpha"],
          converters: ["converter_hl_dir"],
          columns: ["icon_filename"],
        },
        dpp: {
          defaultAction: "cd",
          actions: {
            update: async (args: ActionArguments<Params>) => {
              const names = args.items.map((item) =>
                (item.action as DppAction).__name
              );

              await args.denops.call(
                "dpp#async_ext_action",
                "installer",
                "update",
                { names },
              );

              return Promise.resolve(ActionFlags.None);
            },
          },
        },
        command_args: {
          defaultAction: "execute",
        },
        help: {
          defaultAction: "open",
        },
        markdown: {
          sorters: [],
        },
        line: {
          matchers: [
            "matcher_kensaku",
          ],
        },
        path_history: {
          defaultAction: "uiCd",
        },
        rg: {
          matchers: [
            "matcher_substring",
            "matcher_files",
          ],
          sorters: ["sorter_alpha"],
        },
      },
      sourceParams: {
        file_git: {
          cmd: ["git", "ls-files", "-co", "--exclude-standard"],
        },
        rg: {
          args: [
            "--ignore-case",
            "--column",
            "--no-heading",
            "--color",
            "never",
          ],
        },
        file_rg: {
          cmd: [
            "rg",
            "--files",
            "--glob",
            "!.git",
            "--color",
            "never",
            "--no-messages",
          ],
          updateItems: 50000,
        },
      },
      filterParams: {
        matcher_kensaku: {
          highlightMatched: "Search",
        },
        matcher_substring: {
          highlightMatched: "Search",
        },
        matcher_ignore_files: {
          ignoreGlobs: ["test_*.vim"],
          ignorePatterns: [],
        },
        converter_hl_dir: {
          hlGroup: ["Directory", "Keyword"],
        },
      },
      kindOptions: {
        file: {
          defaultAction: "open",
          actions: {
            grep: async (args: ActionArguments<Params>) => {
              const action = args.items[0]?.action as FileAction;

              await args.denops.call("ddu#start", {
                name: args.options.name,
                push: true,
                sources: [
                  {
                    name: "rg",
                    params: {
                      path: action.path,
                      input: await fn.input(
                        args.denops,
                        "Pattern: ",
                      ),
                    },
                  },
                ],
              });

              return Promise.resolve(ActionFlags.None);
            },
          },
        },
        word: {
          defaultAction: "append",
        },
        deol: {
          defaultAction: "switch",
        },
        action: {
          defaultAction: "do",
        },
        readme_viewer: {
          defaultAction: "open",
        },
        url: {
          defaultAction: "browse",
        },
      },
      kindParams: {},
      actionOptions: {
        narrow: {
          quit: false,
        },
        tabopen: {
          quit: false,
        },
      },
    });

    return Promise.resolve();
  }
}
