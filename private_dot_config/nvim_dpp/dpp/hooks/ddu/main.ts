import { type SourceOptions } from "jsr:@shougo/ddu-vim@~6.2.0/types";

import {
  BaseConfig,
  type ConfigArguments,
} from "jsr:@shougo/ddu-vim@~6.2.0/config";

import * as autocmd from "jsr:@denops/std/autocmd";

const augroup = "RcAutocmd:Ddu";

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
  file_hl_dir: {
    ...Filters.fzf,
    converters: ["converter_hl_dir"],
  },
  file_icons: {
    ...Filters.fzf,
    columns: ["icon_filename"],
  },
  file_hl_dir_icons: {
    ...Filters.fzf,
    converters: [
      "converter_hl_dir",
    ],
    columns: ["icon_filename"],
  },
  git_status: {
    ...Filters.fzf,
    converters: [
      "converter_hl_dir",
      "converter_git_status",
    ],
    columns: ["icon_filename"],
  },
  rg: {
    matchers: [
      "matcher_substring",
      "matcher_files",
    ],
    sorters: ["sorter_alpha"],
    converters: [],
    columns: ["icon_filename"],
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
      buffer: {
        ...FiltersLocal.file_hl_dir_icons,
      },
      file: {
        ...FiltersLocal.file_hl_dir_icons,
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
      line: {
        matchers: ["matcher_kensaku"],
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
}

function applyLocalPatch(args: ConfigArguments) {
  args.contextBuilder.patchLocal("dpp", {
    sources: ["dpp"],
  });

  args.contextBuilder.patchLocal("buffer_mru", {
    sources: ["buffer", "mru"],
  });

  for (const type of ["mru", "mrw", "mrr", "mrd"]) {
    args.contextBuilder.patchLocal(type, {
      sources: [
        {
          name: "mr",
          options: {
            converters: ["converter_hl_dir"],
            columns: ["icon_filename"],
          },
          params: {
            kind: type,
          },
        },
      ],
    });
  }
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
