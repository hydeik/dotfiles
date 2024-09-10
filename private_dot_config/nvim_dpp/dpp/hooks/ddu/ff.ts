import {
  ActionFlags,
  type BaseParams,
  type DduOptions,
  type SourceOptions,
  type UiActionArguments,
} from "jsr:@shougo/ddu-vim@~6.1.0/types";

import {
  BaseConfig,
  type ConfigArguments,
} from "jsr:@shougo/ddu-vim@~6.1.0/config";

import { Params as DduUiFfParams } from "jsr:@shougo/ddu-ui-ff@~1.4.0";

// import { type ActionData as FileAction } from "jsr:@shougo/ddu-kind-file@~0.9.0";
// import { type Params as FfParams } from "jsr:@shougo/ddu-ui-ff@~1.4.0";
// import { type Params as FilerParams } from "jsr:@shougo/ddu-ui-filer@~1.4.0";

import type { Denops } from "jsr:@denops/std@~7.1.0";
// import * as fn from "jsr:@denops/std@~7.1.0/function";
import * as autocmd from "jsr:@denops/std/autocmd";
import * as option from "jsr:@denops/std/option";

import { is } from "jsr:@core/unknownutil";

const augroup = "RcAutocmd:DduUiFf";

type Filter = {
  matchers: SourceOptions["matchers"];
  sorters: SourceOptions["sorters"];
  converters: SourceOptions["converters"];
};

function updateFilter(args: UiActionArguments<BaseParams>, filter: Filter) {
  const sources = args.options.sources.map((s) => {
    if (is.String(s)) {
      s = { name: s };
    }
    return {
      ...s,
      options: {
        ...s.options,
        ...filter,
      },
    };
  });
  args.ddu.updateOptions({
    sources,
  });
}

type DduUiFfSize = {
  winRow: number;
  winCol: number;
  winWidth: number;
  winHeight: number;
  previewFloating: boolean;
  previewSplit: "vertical" | "horizontal";
  previewRow: number;
  previewCol: number;
  previewHeight: number;
  previewWidth: number;
};

async function calculateUiSize(
  denops: Denops,
  widthRatio: number,
  heightRatio: number,
  splitRatio: number,
): Promise<DduUiFfSize> {
  const columns = await option.columns.get(denops);
  const lines = await option.lines.get(denops);
  const FRAME_SIZE = 2;

  const winWidthTotal = Math.floor(columns * widthRatio);
  const winHeightTotal = Math.floor(lines * heightRatio);
}

async function setUiSize(args: ConfigArguments) {
  if (args.denops.meta.host === "vim") {
    args.contextBuilder.patchGlobal({
      uiParams: {
        ff: {
          previewWidth: Math.floor(await option.columns.get(args.denops)),
        },
      },
    });
  } else {
    const [winCol, winRow, winWidth, winHeight] = await calculateUiSize(
      args.denops,
    );
    const halfWidth = Math.floor(winWidth / 2);
  }
}

export class Config extends BaseConfig {
  async config(args: ConfigArguments) {
    const nvim = args.denops.meta.host === "nvim";
    const floating = nvim;

    args.contextBuilder.patchGlobal({
      ui: "ff",
      uiParams: {
        ff: {
          autoAction: {
            name: "preview",
          },
          floatingBorder: "single",
          previewFloating: floating,
          previewFloatingBorder: "single",
          previewFloatingZindex: 100,
          previewSplit: "vertical",
          split: floating ? "floating" : "tab",
        } satisfies Partial<DduUiFfParams>,
      },
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
      },
    });

    await autocmd.group(args.denops, augroup, (helper) => {
      helper.remove("*");
    });

    await autocmd.group(args.denops, augroup, (helper) => {
      // helper.define(
      //   "ColorScheme",
      //   "*",
      //   () => onColorScheme(args),
      // );

      // Reset UI window sizes
      helper.define(
        "VimResized",
        "*",
        () => setUiSize(args),
        { async: true },
      );
    });
  }
}
