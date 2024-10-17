import {
  BaseConfig,
  type ConfigArguments,
} from "jsr:@shougo/ddu-vim@~6.2.0/config";
import {
  type DduOptions,
  type FilterName,
  type UserFilter,
} from "jsr:@shougo/ddu-vim@~6.2.0/types";

import { type Params as FilerParams } from "jsr:@shougo/ddu-ui-filer@~1.4.0";

import * as autocmd from "jsr:@denops/std/autocmd";
import * as fn from "jsr:@denops/std/function";
import * as lambda from "jsr:@denops/std/lambda";
import * as mapping from "jsr:@denops/std/mapping";
import { b } from "jsr:@denops/std/variable";

import { is } from "jsr:@core/unknownutil";

import { calculateUiSize } from "./helper.ts";

const augroup = "RcAutocmd:DduUiFiler";

async function setUiSize(args: ConfigArguments) {
  const previewRatio = 0.6;

  args.contextBuilder.patchGlobal({
    uiParams: {
      filer: {
        ...await calculateUiSize(
          args.denops,
          previewRatio,
          true,
        ),
      } as Partial<FilerParams>,
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
    const paramsStr = params == null ? "" : ", " +
      JSON.stringify(params, (_, v) => is.Boolean(v) ? "__ddu__" + v : v)
        .replaceAll(/"__ddu__(\w+)"/g, "v:$1");
    return `<Cmd>call ddu#ui#do_action('${name}'${paramsStr})<CR>`;
  };

  const multi_actions = (params?: unknown) => {
    const paramsStr = JSON.stringify(
      params,
      (_, v) => is.Boolean(v) ? "__ddu__" + v : v,
    )
      .replaceAll(/"__ddu__(\w+)"/g, "v:$1");
    return `<Cmd>call ddu#ui#multi_actions(${paramsStr})<CR>`;
  };

  const itemAction = (name: string, params: unknown = {}) => {
    return action("itemAction", { name, params });
  };

  const toggleHidden = async (name: string): Promise<UserFilter[]> => {
    const ui_name: string | undefined = await b.get(denops, "ddu_ui_name");
    const ddu = await denops.dispatcher.getCurrent(ui_name) as DduOptions;
    const matchers = ddu.sourceOptions?.[name]?.matchers ?? [];
    console.log(typeof matchers);
    console.log(matchers);
    const idx = matchers.indexOf("matcher_hidden");
    return idx > -1
      ? matchers.toSpliced(idx, 1)
      : matchers.concat(["matcher_hidden"]);
  };

  const ddu_filer = lambda.register(denops, async () => {
    await mapping.map(denops, "<CR>", action("itemAction"), nno);
    await mapping.map(denops, "<Space>", action("toggleSelectItem"), nno);
    await mapping.map(denops, "*", action("toggleAllItems"), nno);
    await mapping.map(denops, "a", action("chooseAction"), nno);
    await mapping.map(denops, "A", action("inputAction"), nno);
    await mapping.map(denops, "q", action("quit"), nno);
    await mapping.map(
      denops,
      "o",
      action("expandItem", {
        mode: "toggle",
        isGrouped: true,
        isInTree: false,
      }),
      nno,
    );
    await mapping.map(denops, "O", action("expandItem", { maxLevel: -1 }), nno);
    await mapping.map(
      denops,
      "c",
      multi_actions([
        ["itemAction", { name: "copy" }],
        ["clearSelectAllItems"],
      ]),
      nno,
    );
    await mapping.map(denops, "d", itemAction("trash"), nno);
    await mapping.map(denops, "D", itemAction("delete"), nno);
    await mapping.map(denops, "m", itemAction("move"), nno);
    await mapping.map(denops, "r", itemAction("rename"), nno);
    await mapping.map(denops, "x", itemAction("executeSystem"), nno);
    await mapping.map(denops, "p", itemAction("paste"), nno);
    await mapping.map(denops, "P", action("togglePreview"), nno);
    await mapping.map(denops, "K", itemAction("newDirectory"), nno);
    await mapping.map(denops, "N", itemAction("newFile"), nno);
    await mapping.map(denops, "L", itemAction("link"), nno);
    await mapping.map(denops, "u", itemAction("undo"), nno);
    await mapping.map(
      denops,
      ".",
      multi_actions([
        ["updateOptions", {
          sourceOptions: {
            file: {
              matchers: await toggleHidden("file"),
            },
          },
        }],
        ["redraw", { method: "refreshItems" }],
      ]),
      nno,
    );
    await mapping.map(
      denops,
      "~",
      itemAction("narrow", { path: Deno.env.get("HOME") }),
      nno,
    );
    await mapping.map(
      denops,
      "=",
      itemAction("narrow", { path: await fn.getcwd(denops) }),
      nno,
    );
    await mapping.map(
      denops,
      "h",
      itemAction("narrow", { path: ".." }),
      nno,
    );
    await mapping.map(
      denops,
      "H",
      "<Cmd>ddu#start({ sources: [{ name: 'path_history' }] })<CR>",
      nno,
    );

    await mapping.map(
      denops,
      "<C-l>",
      action("redraw", { method: "refreshItem" }),
      nno,
    );
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
  });

  await autocmd.group(denops, augroup, (helper) => {
    helper.define(
      "FileType",
      "ddu-filer",
      `call denops#notify("${args.denops.name}", "${ddu_filer}", [])`,
    );
  });
}

export class Config extends BaseConfig {
  async config(args: ConfigArguments) {
    args.contextBuilder.patchGlobal({
      uiOptions: {
        filer: {
          toggle: true,
        },
      },
      uiParams: {
        filer: {
          startAutoAction: true,
          autoAction: {
            name: "preview",
          },
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
          sort: "filename",
          split: "floating",
          // splitDirection: "aboveleft",
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
