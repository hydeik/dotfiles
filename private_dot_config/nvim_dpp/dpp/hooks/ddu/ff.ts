import {
  ActionFlags,
  // type BaseParams,
  type DduOptions,
  type SourceOptions,
  // type UiActionArguments,
} from "jsr:@shougo/ddu-vim@~6.2.0/types";

import {
  BaseConfig,
  type ConfigArguments,
} from "jsr:@shougo/ddu-vim@~6.2.0/config";

import { type Params as FfParams } from "jsr:@shougo/ddu-ui-ff@~1.4.0";

import type { Denops } from "jsr:@denops/std";
import * as autocmd from "jsr:@denops/std/autocmd";
import * as lambda from "jsr:@denops/std/lambda";
import * as mapping from "jsr:@denops/std/mapping";
import * as option from "jsr:@denops/std/option";
import { b } from "jsr:@denops/std/variable";

import { calculateUiSize } from "./helper.ts";

const augroup = "RcAutocmd:DduUi";

async function setUiSize(args: ConfigArguments) {
  const mayVSplit = await option.columns.get(args.denops) >= 140;
  const previewRatio = 0.5;

  args.contextBuilder.patchGlobal({
    uiParams: {
      ff: {
        ...await calculateUiSize(
          args.denops,
          previewRatio,
          mayVSplit,
        ),
      } as Partial<FfParams>,
    },
  });

  args.contextBuilder.patchLocal("search", {
    uiParams: {
      ff: {
        ...await calculateUiSize(
          args.denops,
          previewRatio,
          false,
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

  const itemAction = (name: string, params: unknown = {}) => {
    return action("itemAction", { name, params });
  };

  const actionL = (name: string, params: unknown = {}) => {
    return (denops: Denops) => {
      return denops.call("ddu#ui#do_action", name, params);
    };
  };
  const itemActionL = (name: string, params: unknown = {}) => {
    return actionL("itemAction", { name, params });
  };

  const ddu_ff = lambda.register(denops, async () => {
    const ui_name: string | undefined = await b.get(denops, "ddu_ui_name");

    await mapping.map(denops, "<CR>", action("itemAction"), nno);
    await mapping.map(denops, "<Space>", action("toggleSelectItem"), {
      ...opt,
      mode: ["n", "x"],
    });
    await mapping.map(denops, "*", action("toggleAllItems"), nno);
    await mapping.map(denops, "a", action("chooseAction"), nno);
    await mapping.map(denops, "A", action("inputAction"), nno);
    await mapping.map(denops, "G", itemAction("grep"), nno);
    await mapping.map(denops, "i", action("openFilterWindow"), nno);
    await mapping.map(denops, "K", action("kensaku"), nno);
    await mapping.map(
      denops,
      "o",
      action("expandItem", { mode: "toggle" }),
      nno,
    );
    await mapping.map(denops, "O", action("collapseItem"), nno);
    await mapping.map(denops, "q", action("quit"), nno);
    await mapping.map(denops, "yy", itemAction("yank"), nno);
    await mapping.map(denops, "<C-g>", action("quit"), nno);
    await mapping.map(denops, "<C-j>", action("cursorNext"), nno);
    await mapping.map(denops, "<C-k>", action("cursorPrevious"), nno);
    await mapping.map(
      denops,
      "<C-l>",
      action("redraw", { method: "refreshItem" }),
      nno,
    );
    await mapping.map(denops, "<C-q>", itemAction("quickfix"), nno);
    await mapping.map(
      denops,
      "<C-t>",
      itemAction("open", { command: "tabedit" }),
      nno,
    );
    await mapping.map(
      denops,
      "<C-v>",
      itemAction("open", { command: "vsplit" }),
      nno,
    );
    await mapping.map(
      denops,
      "<C-x>",
      itemAction("open", { command: "split" }),
      nno,
    );

    await mapping.map(denops, "N", itemAction("new"), nno);
    await mapping.map(denops, "X", itemAction("delete"), nno);

    if (ui_name === "git_status") {
      await mapping.map(denops, "c", itemAction("commit"), nno);
      await mapping.map(denops, "d", itemAction("diff"), nno);
      await mapping.map(denops, "h", itemAction("add"), nno);
      await mapping.map(denops, "l", itemAction("reset"), nno);
    }

    if (ui_name === "git_diff") {
      const p = lambda.add(denops, async () => {
        const view = await denops.call("winsaveview");
        await itemActionL("applyPatch")(denops);
        await denops.call("winrestview", view);
      });
      await mapping.map(denops, "p", `<Cmd>call ${p.request()}<CR>`, nno);
    }
  });

  await autocmd.group(denops, augroup, (helper) => {
    helper.define(
      "FileType",
      "ddu-ff",
      `call denops#notify("${args.denops.name}", "${ddu_ff}", [])`,
    );
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
          displaySourceName: "long",
          floatingBorder: "rounded",
          floatingTitle: "Results",
          floatingTitlePos: "center",
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
          startAutoAction: true,
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
