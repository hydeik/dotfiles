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

import { type Params as FfParams } from "jsr:@shougo/ddu-ui-ff@~1.4.0";

// import { type Params as FfParams } from "jsr:@shougo/ddu-ui-ff@~1.4.0";
// import { type Params as FilerParams } from "jsr:@shougo/ddu-ui-filer@~1.4.0";

import type { Denops } from "jsr:@denops/std@~7.1.0";
// import * as fn from "jsr:@denops/std@~7.1.0/function";
import * as autocmd from "jsr:@denops/std/autocmd";
import * as option from "jsr:@denops/std/option";

import { is } from "jsr:@core/unknownutil";

const augroup = "RcAutocmd:DduUiFf";

// type Filter = {
//   matchers: SourceOptions["matchers"];
//   sorters: SourceOptions["sorters"];
//   converters: SourceOptions["converters"];
// };
//
// function updateFilter(args: UiActionArguments<BaseParams>, filter: Filter) {
//   const sources = args.options.sources.map((s) => {
//     if (is.String(s)) {
//       s = { name: s };
//     }
//     return {
//       ...s,
//       options: {
//         ...s.options,
//         ...filter,
//       },
//     };
//   });
//   args.ddu.updateOptions({
//     sources,
//   });
// }

type FfWindowSize = {
  rowTopLeft: number;
  colTopLeft: number;
  width: number;
  height: number;
};

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

const FILTER_HEIGHT = 3;
const SPACING = 1; // spacing between result and preview windows

async function calculateWindowSize(
  denops: Denops,
  widthRatio: number,
  heightRatio: number,
): Promise<[x: number, y: number, width: number, height: number]> {
  const columns = await option.columns.get(denops);
  const lines = await option.lines.get(denops);
  // Width and height of the floating window
  const width = Math.floor(columns * widthRatio);
  const height = Math.floor(lines * heightRatio);
  // Top-left corner position of the floating window
  const x = Math.floor((lines - width) / 2);
  const y = Math.floor((columns - height) / 2);
  return [x, y, width, height];
}

async function calculateUiSizeFloatingVertical(
  denops: Denops,
  widthRatio: number,
  heightRatio: number,
  prevewRatio: number,
): Promise<DduUiFfSize> {
  const [row, col, width, height] = await calculateWindowSize(
    denops,
    widthRatio,
    heightRatio,
  );

  const preview_width = Math.floor(height * prevewRatio);

  return {
    winRow: row,
    winCol: col,
    winWidth: width - preview_width - SPACING,
    winHeight: height - FILTER_HEIGHT,
    previewFloating: true,
    previewSplit: "vertical",
    previewRow: row,
    previewCol: col + width - preview_width + SPACING,
    previewHeight: height - FILTER_HEIGHT,
    previewWidth: preview_width,
  };
}

async function calculateUiSizeFloatingHorizontal(
  denops: Denops,
  widthRatio: number,
  heightRatio: number,
  prevewRatio: number,
): Promise<DduUiFfSize> {
  const [row, col, width, height] = await calculateWindowSize(
    denops,
    widthRatio,
    heightRatio,
  );

  const preview_height = Math.floor((height - FILTER_HEIGHT) * prevewRatio);
  return {
    winRow: row + preview_height + SPACING,
    winCol: col,
    winWidth: width,
    winHeight: height - preview_height,
    previewFloating: true,
    previewSplit: "horizontal",
    previewRow: row,
    previewCol: col,
    previewHeight: preview_height - SPACING,
    previewWidth: width,
  };
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
    args.contextBuilder.patchGlobal({
      ui: "ff",
      uiParams: {
        ff: {
          autoAction: {
            name: "preview",
          },
          floatingBorder: "rounded",
          previewFloating: true,
          previewFloatingBorder: "single",
          previewFloatingZindex: 100,
          previewSplit: "vertical",
          split: "floating",
        } satisfies Partial<FfParams>,
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
