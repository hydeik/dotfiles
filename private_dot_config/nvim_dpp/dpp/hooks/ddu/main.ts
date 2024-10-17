import {
  type ActionArguments,
  ActionFlags,
  type SourceOptions,
} from "jsr:@shougo/ddu-vim@~6.2.0/types";

import {
  BaseConfig,
  type ConfigArguments,
} from "jsr:@shougo/ddu-vim@~6.2.0/config";

import { type ActionData as FileAction } from "jsr:@shougo/ddu-kind-file@~0.9.0";
import { type ActionData as GitStatusActionData } from "jsr:@kuuote/ddu-kind-git-status";

import * as autocmd from "jsr:@denops/std/autocmd";
import * as fn from "jsr:@denops/std/function";
import { join } from "jsr:@std/path/join";
import * as u from "jsr:@core/unknownutil";

const augroup = "RcAutocmd:Ddu";

type Never = Record<never, never>;

type Params = Record<string, unknown>;

type DppAction = {
  path: string;
  __name: string;
};

type Filter = {
  matchers: SourceOptions["matchers"];
  sorters: SourceOptions["sorters"];
  converters: SourceOptions["converters"];
  columns: SourceOptions["columns"];
};

type Filters = Record<string, Filter>;

const Filters = {
  fzf: {
    matchers: ["matcher_fzf"],
    sorters: ["sorter_fzf"],
    converters: [],
    columns: [],
  },
  sorter_alpha_path: {
    matchers: [],
    sorters: ["sorter_alpha_path"],
    converters: [],
    columns: [],
  },
  mtime_substring: {
    matchers: ["matcher_substring"],
    sorters: ["sorter_mtime"],
    converters: [],
    columns: [],
  },
} satisfies Filters;

const FiltersLocal = {
  file_hl_dir_icons: {
    ...Filters.fzf,
    converters: ["converter_hl_dir"],
    columns: ["icon_filename"],
  },
  file_hl_dir_icons_for_ff: {
    ...Filters.fzf,
    converters: ["converter_hl_dir"],
    columns: ["icon_filename_for_ff"],
  },
  git_branch: {
    ...Filters.fzf,
    columns: [
      "git_branch_head",
      "git_branch_remote",
      "git_branch_name",
      "git_branch_upstream",
      "git_branch_author",
      "git_branch_date",
    ],
  },
  git_status: {
    ...Filters.fzf,
    converters: [
      "converter_hl_dir",
      "converter_git_status",
    ],
    columns: ["icon_filename_for_ff"],
  },
  lsp_symbol: {
    ...Filters.fzf,
    converters: ["converter_lsp_symbol"],
  },
  rg: {
    matchers: [
      "matcher_substring",
      "matcher_files",
    ],
    sorters: ["sorter_alpha"],
    converters: [],
    columns: ["icon_filename_for_ff"],
  },
} satisfies Filters;

const IgnoredDirs = [
  ".git",
  ".svn",
  ".venv",
  "__pycache__",
  ".pytest_cache",
  "node_modules",
];

const CustomIcons = {
  colors: {
    default: "MiniIconsGrey",
    aqua: "MiniIconsCyan",
    blue: "MiniIconsAzure",
    brown: "MiniIconsOrange",
    darkBlue: "MiniIconsBlue",
    darkOrange: "MiniIconsOrange",
    green: "MiniIconsGreen",
    lightGreen: "MiniIconsGreen",
    orange: "MiniIconsOrange",
    pink: "MiniIconsRed",
    purple: "MiniIconsPurple",
    salmon: "MiniIconsRed",
    yellow: "MiniIconsYellow",
  },
  defaultIcon: { icon: "" },
  customFileIcons: {
    gotmpl: { icon: "󰟓", color: "MiniIconsGrey" },
  },
  customSpecialIcons: {
    ".keep": { icon: "󰊢", color: "MiniIconsGrey" },
    "devcontainer.json": { icon: "", color: "MiniIconsAzure" },
    ".go-version": { icon: "", color: "MiniIconsBlue" },
    ".eslintrc.js": { icon: "󰱺", color: "MiniIconsYellow" },
    ".node-version": { icon: "", color: "MiniIconsGreen" },
    ".prettierrc": { icon: "", color: "MiniIconsPurple" },
    ".yarnrc.yml": { icon: "", color: "MiniIconsBlue" },
    "eslint.config.js": { icon: "󰱺", color: "MiniIconsYellow" },
    "package.json": { icon: "", color: "MiniIconsGreen" },
    "tsconfig.json": { icon: "", color: "MiniIconsAzure" },
    "tsconfig.build.json": { icon: "", color: "MiniIconsAzure" },
    "yarn.lock": { icon: "", color: "MiniIconsBlue" },
  },
};

function setupGit(args: ConfigArguments) {
  args.contextBuilder.patchGlobal({
    sourceOptions: {
      git_branch: {
        ...FiltersLocal.git_branch,
      },
      git_status: {
        ...FiltersLocal.git_status,
      },
    },
    kindOptions: {
      git_branch: {
        defaultAction: "switch",
      },
      git_status: {
        actions: {
          commit: async () => {
            await args.denops.call("Gin commit");
            return ActionFlags.None;
          },
          // show diff of file
          // using https://github.com/kuuote/ddu-source-git_diff
          // example:
          //   call ddu#ui#do_action('itemAction', #{name: 'diff'})
          //   call ddu#ui#do_action('itemAction', #{name: 'diff', params: #{cached: v:true}})
          diff: async (args: ActionArguments<Params>) => {
            const action = args.items[0].action as GitStatusActionData;
            const path = join(action.worktree, action.path);
            await args.denops.call("ddu#start", {
              name: "file:git_diff",
              sources: [{
                name: "git_diff",
                options: {
                  path,
                },
                params: {
                  ...u.maybe(args.actionParams, u.isRecord) ?? {},
                  onlyFile: true,
                },
              }],
            });
            return ActionFlags.None;
          },
          // fire GinPatch command to selected items
          // using https://github.com/lambdalisue/gin.vim
          patch: async (args: ActionArguments<Never>) => {
            for (const item of args.items) {
              const action = item.action as GitStatusActionData;
              await args.denops.cmd("tabnew");
              await args.denops.cmd("tcd " + action.worktree);
              await args.denops.cmd("GinPatch ++no-head " + action.path);
            }
            return ActionFlags.None;
          },
        },
        defaultAction: "open",
      },
    },
  });

  args.contextBuilder.patchLocal("git_diff", {
    actionOptions: {
      applyPatch: { quit: false },
    },
    souces: ["git_diff"],
    uiParams: {
      ff: {
        maxDisplayItems: 100000,
        maxHeightItems: 100000,
      },
    },
  });
}

function setupLsp(args: ConfigArguments) {
  args.contextBuilder.patchGlobal({
    kindOptions: {
      lsp: {
        defaultAction: "open",
      },
      lsp_codeAction: {
        defaultAction: "apply",
      },
    },
    sourceOptions: {
      lsp_definition: {
        ...FiltersLocal.file_hl_dir_icons_for_ff,
      },
      lsp_references: {
        ...FiltersLocal.file_hl_dir_icons_for_ff,
      },
      lsp_documentSymbol: {
        ...FiltersLocal.lsp_symbol,
      },
      lsp_workspaceSymbol: {
        ...FiltersLocal.lsp_symbol,
      },
    },
  });
}

function applyLocalPatch(args: ConfigArguments) {
  for (const type of ["mru", "mrw", "mrr", "mrd"]) {
    args.contextBuilder.patchLocal(type, {
      sources: [
        {
          name: "mr",
          options: {
            converters: ["converter_hl_dir"],
            columns: ["icon_filename_for_ff"],
          },
          params: {
            kind: type,
          },
        },
      ],
    });
  }
}

function mainConfig(args: ConfigArguments) {
  args.setAlias("source", "file_fd", "file_external");
  args.setAlias("source", "file_rg", "file_external");
  args.setAlias("source", "file_git", "file_external");
  args.setAlias("column", "icon_filename_for_ff", "icon_filename");

  args.contextBuilder.patchGlobal({
    actionOptions: {
      narrow: { quit: false },
      echo: { quit: false },
      echoDiff: { quit: false },
    },
    columnParams: {
      icon_filename: {
        ...CustomIcons,
        ...{
          useLinkIcon: "grayout",
        },
      },
      icon_filename_for_ff: {
        ...CustomIcons,
        ...{
          padding: 0,
          pathDisplayOption: "relative",
        },
      },
    },
    kindOptions: {
      action: {
        defaultAction: "do",
      },
      callback: {
        defaultAction: "call",
      },
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
                    input: await fn.input(args.denops, "Pattern: "),
                  },
                },
              ],
            });

            return Promise.resolve(ActionFlags.None);
          },
        },
      },
      readme_viewer: {
        defaultAction: "open",
      },
      tag: {
        defaultAction: "jump",
      },
      url: {
        defaultAction: "browse",
      },
    },
    sourceOptions: {
      _: {
        ignoreCase: true,
        smartCase: true,
        ...Filters.fzf,
      },
      buffer: {
        ...FiltersLocal.file_hl_dir_icons_for_ff,
      },
      command_args: {
        defaultAction: "execute",
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
      file: {
        ...FiltersLocal.file_hl_dir_icons,
      },
      file_rec: {
        ...FiltersLocal.file_hl_dir_icons_for_ff,
      },
      file_fd: {
        ...FiltersLocal.file_hl_dir_icons_for_ff,
      },
      file_rg: {
        ...FiltersLocal.file_hl_dir_icons_for_ff,
      },
      line: {
        matchers: ["matcher_kensaku"],
      },
      path_history: {
        defaultAction: "uiCd",
      },
      rg: {
        ...FiltersLocal.rg,
      },
    },
    sourceParams: {
      file_rec: {
        ignoredDirectories: IgnoredDirs,
      },
      file_fd: {
        cmd: [
          "fd",
          ".",
          "--hidden",
          "--follow",
          "--no-ignore",
          "--type",
          "f",
          "--color",
          "never",
          ...IgnoredDirs.map((x) => {
            return ["--exclude", x];
          }).flat(),
        ],
      },
      file_rg: {
        cmd: [
          "rg",
          "--files",
          "--hidden",
          "--smart-case",
          "--no-ignore-vcs",
          "--color=never",
          ...IgnoredDirs.map((x) => {
            return "--glob=!" + x;
          }),
        ],
      },
    },
  });

  setupGit(args);
  setupLsp(args);
  applyLocalPatch(args);
}

export class Config extends BaseConfig {
  async config(args: ConfigArguments) {
    await autocmd.group(args.denops, augroup, (helper) => {
      helper.remove("*");
      helper.define("User", "RcAutocmd:Ddu:Ready", ":", { once: true });
    });
    mainConfig(args);
    autocmd.emit(args.denops, "User", "RcAutocmd:Ddu:Ready");
  }
}
