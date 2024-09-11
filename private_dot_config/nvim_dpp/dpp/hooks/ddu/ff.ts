import {
  ActionFlags,
  // type BaseParams,
  type DduOptions,
  type SourceOptions,
  // type UiActionArguments,
} from "jsr:@shougo/ddu-vim@~6.1.0/types";

import {
  BaseConfig,
  type ConfigArguments,
} from "jsr:@shougo/ddu-vim@~6.1.0/config";

import { type Params as FfParams } from "jsr:@shougo/ddu-ui-ff@~1.4.0";

import { type Params as FfParams } from "jsr:@shougo/ddu-ui-ff@~1.4.0";

import type { Denops } from "jsr:@denops/std";
import * as autocmd from "jsr:@denops/std/autocmd";
import * as lambda from "jsr:@denops/std/lambda";
import * as mapping from "jsr:@denops/std/mapping";
import * as option from "jsr:@denops/std/option";
import { b } from "jsr:@denops/std/variable";

const augroup = "RcAutocmd:DduUiFf";

// type Filter = {
//   matchers: SourceOptions["matchers"];
//   sorters: SourceOptions["sorters"];
//   converters: SourceOptions["converters"];
// };

type DduUiSize = {
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

const FILTER_HEIGHT = 2;
const SPACING = 1;

async function calculateWindowSize(
  denops: Denops,
  widthRatio: number,
  heightRatio: number,
): Promise<[x: number, y: number, width: number, height: number]> {
  const columns = await option.columns.get(denops);
  const lines = await option.lines.get(denops);

  const width = Math.floor(columns * widthRatio);
  const height = Math.floor(lines * heightRatio);
  const x = Math.floor((columns - width) / 2);
  const y = Math.floor((lines - height) / 2);

  return [x, y, width, height];
}

async function calculateUiSize(
  denops: Denops,
  widthRatio: number,
  heightRatio: number,
  previewRatio: number,
  verticalSplit: boolean,
): Promise<DduUiSize> {
  const [x, y, width, height] = await calculateWindowSize(
    denops,
    widthRatio,
    heightRatio,
  );

  if (verticalSplit) {
    const previewLength = Math.floor(width * previewRatio);
    const winLength = width - previewLength;
    return {
      winRow: x,
      winCol: y,
      winWidth: winLength - SPACING,
      winHeight: height - FILTER_HEIGHT - SPACING,
      previewFloating: true,
      previewSplit: "vertical",
      previewRow: x,
      previewCol: y + winLength + SPACING,
      previewWidth: previewLength,
      previewHeight: height - FILTER_HEIGHT - SPACING,
    };
  }

  const previewLength = Math.floor(
    (height - FILTER_HEIGHT - SPACING) * previewRatio,
  );
  const winLength = height - previewLength;
  return {
    winRow: x + previewLength + SPACING,
    winCol: y,
    winWidth: width,
    winHeight: winLength - SPACING,
    previewFloating: true,
    previewSplit: "horizontal",
    previewRow: x,
    previewCol: y,
    previewWidth: previewLength,
    previewHeight: previewLength,
  };
}

async function setUiSize(args: ConfigArguments) {
  const mayVSplit = await option.columns.get(args.denops) >= 140;
  const widthRatio = 0.9;
  const heightRatio = 0.8;
  const previewRatio = 0.5;

  args.contextBuilder.patchGlobal({
    uiParams: {
      ff: {
        ...await calculateUiSize(
          args.denops,
          widthRatio,
          heightRatio,
          previewRatio,
          mayVSplit,
        ),
      } as Partial<FfParams>,
    },
  });
}

async function setFileTypeAutocmd(args: ConfigArguments) {
  const { denops } = args;
  const opt: mapping.MapOptions = {
    buffer: true,
    silent: true,
    nowait: true,
  };
  const nno: mapping.MapOptions = {
    ...opt,
    mode: ["n"],
  };
  const action = (name: string, params?: unknown) => {
    return `<Cmd>call ddu#ui#do_action('${name}'${
      params != null ? ", " + JSON.stringify(params) : ""
    })<CR>`;
  };

  const keymapTable: Record<string, lambda.Fn> = {
    // common mappings
    _: async () => {
      await mapping.map(denops, "<CR>", action("itemAction"), nno);
      await mapping.map(denops, "<Space>", action("toggleSelectItem"), {
        ...opt,
        mode: ["n", "x"],
      });
      await mapping.map(denops, "*", action("toggleAllItems"), nno);
      await mapping.map(denops, "a", action("chooseAction"), nno);
      await mapping.map(denops, "A", action("inputAction"), nno);
      await mapping.map(denops, "i", action("openFilterWindow"), nno);
      await mapping.map(denops, "K", action("kensaku"), nno);
      // await mapping.map(
      //   denops,
      //   "o",
      //   action("expandItem", { mode: "toggle" }),
      //   nno,
      // );
      await mapping.map(denops, "O", action("collapseItem"), nno);
      await mapping.map(denops, "p", action("previewPath"), nno);
      await mapping.map(denops, "P", action("togglePreview"), nno);
      await mapping.map(denops, "q", action("quit"), nno);

      await mapping.map(denops, "<C-g>", action("quit"), nno);
      await mapping.map(denops, "<C-j>", action("cursorNext"), nno);
      await mapping.map(denops, "<C-k>", action("cursorPrevious"), nno);
      // await mapping.map(
      //   denops,
      //   "<C-l>",
      //   action("redraw", { method: "refreshItem" }),
      //   nno,
      // );
      await mapping.map(denops, "<C-q>", action("quickfix"), nno);
    },
  };

  const ddu_ff = lambda.register(denops, async () => {
    await keymapTable["_"]?.();
    // const name = await b.get(denops, "ddu_ui_name");
    // if (name != null) {
    //   await keymapTable[name]?.();
    // }
  });

  await autocmd.group(denops, augroup, (helper) => {
    helper.define("FileType", "ddu-ff", ddu_ff);
  });
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
          floatingTitle: "Results",
          floatingTitlePos: "center",
          inputFunc: "cmdline#input",
          previewFloatingBorder: "rounded",
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
          prompt: "> ",
          split: "floating",
          // startAutoAction: true,
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
              await args.denops.cmd("echomsg 'change to kensaku matcher'");
              return ActionFlags.Persist;
            },
          },
        },
      },
    });

    const set_ui_size = lambda.register(args.denops, async () => {
      await setUiSize(args);
    });

    await autocmd.group(args.denops, augroup, (helper) => {
      helper.remove("*");
    });

    await autocmd.group(args.denops, augroup, (helper) => {
      // Reset UI window sizes
      helper.define(
        "VimResized",
        "*",
        `call denops#notify("${args.denops.name}", "${set_ui_size}", [])`,
      );
    });

    await setUiSize(args);
    await setFileTypeAutocmd(args);
  }
}
