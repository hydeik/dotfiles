import {
  type ActionArguments,
  ActionFlags,
  type DduOptions,
  type SourceOptions,
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
import * as autocmd from "jsr:@denops/std/autocmd";

type Params = Record<string, unknown>;

type DppAction = {
  path: string;
  __name: string;
};

const augroup = "RcAutocmd:Ddu";

type Filter = {
  matchers: SourceOptions["matchers"];
  sorters: SourceOptions["sorters"];
  converters: SourceOptions["converters"];
};

type Filters = Record<string, Filter>;

const Filters = {
  fzf: {
    matchers: ["matcher_fzf"],
    sorters: ["sorter_fzf"],
    converters: [],
  },
  sorter_alpha_path: {
    matchers: [],
    sorters: ["sorter_alpha_path"],
    converters: [],
  },
  mtime_substring: {
    matchers: ["matcher_substring"],
    sorters: ["sorter_mtime"],
    converters: [],
  },
} satisfies Filters;

const FiltersLocal = {
  file_hl_dir: {
    ...Filters.fzf,
    converters: ["converter_hl_dir"],
  },
  file_icons: {
    ...Filters.fzf,
    converters: ["icon_filename"],
  },
  file_hl_dir_icons: {
    ...Filters.fzf,
    converters: [
      "converter_hl_dir",
      "icon_filename",
    ],
  },
  git_status: {
    ...Filters.fzf,
    converters: [
      "converter_hl_dir",
      "icon_filename",
      "converter_git_status",
    ],
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

function mainConfig(args: ConfigArguments) {
  args.setAlias("source", "file_fd", "file_external");
  args.setAlias("source", "file_rg", "file_external");
  args.setAlias("source", "file_git", "file_external");

  args.contextBuilder.patchGlobal({
    actionOptions: {
      narrow: { quit: false },
      echo: { quit: false },
      echoDiff: { quit: false },
    },
    kindOptions: {
      callback: {
        defaultAction: "call",
      },
      file: {
        defaultAction: "open",
      },
      lsp: {
        defaultAction: "open",
      },
      lsp_codeAction: {
        defaultAction: "apply",
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
      file: {
        ...FiltersLocal.file_icons,
      },
      file_rec: {
        ...FiltersLocal.file_hl_dir_icons,
      },
      file_fd: {
        ...FiltersLocal.file_hl_dir_icons,
      },
      file_rg: {
        ...FiltersLocal.file_hl_dir_icons,
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
}

function applyLocalPatch(args: ConfigArguments) {
  args.contextBuilder.patchLocal("dpp", {
    sources: ["dpp"],
  });
}

export class Config extends BaseConfig {
  async config(args: ConfigArguments) {
    await autocmd.group(args.denops, augroup, (helper) => {
      helper.remove("*");
      helper.define("User", "RcAutocmd:Ddu:Ready", ":", { once: true });
    });
    mainConfig(args);
    applyLocalPatch(args);
    // await selectorConfig(args);
    autocmd.emit(args.denops, "User", "RcAutocmd:Ddu:Ready");
  }
}
