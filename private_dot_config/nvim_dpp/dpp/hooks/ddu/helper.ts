import type { Denops } from "jsr:@denops/std";
import * as option from "jsr:@denops/std/option";

// type Filter = {
//   matchers: SourceOptions["matchers"];
//   sorters: SourceOptions["sorters"];
//   converters: SourceOptions["converters"];
// };

const PADDING = 1;
const BORDER_SIZE = 1;
const FILTER_HEIGHT = 3;

export type DduUiSize = {
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

async function calculateWindowSize(
  denops: Denops,
): Promise<[row: number, col: number, width: number, height: number]> {
  const columns = await option.columns.get(denops);
  const lines = await option.lines.get(denops);
  const top_bottom_mergin = 4;
  const side_mergin = columns >= 120
    ? Math.floor(columns * 0.1) - PADDING
    : Math.floor(columns * 0.05) - PADDING;

  const width = columns - 2 * side_mergin;
  const height = lines - FILTER_HEIGHT - 2 * top_bottom_mergin;
  const row = FILTER_HEIGHT + top_bottom_mergin;
  const col = side_mergin;

  return [row, col, width, height];
}

export async function calculateUiSize(
  denops: Denops,
  previewRatio: number,
  verticalSplit: boolean,
): Promise<DduUiSize> {
  const [row, col, width, height] = await calculateWindowSize(denops);

  if (verticalSplit) {
    const previewWidth = Math.floor(width * previewRatio);
    const winWidth = width - previewWidth;
    return {
      winRow: row,
      winCol: col,
      winWidth: winWidth - 2 * BORDER_SIZE,
      winHeight: height,
      previewFloating: true,
      previewSplit: "vertical",
      previewRow: row,
      previewCol: col + winWidth,
      previewWidth: previewWidth - 2 * BORDER_SIZE,
      previewHeight: height,
    };
  }

  const previewHeight = Math.floor(height * previewRatio);
  const winHeight = height - previewHeight;
  return {
    winRow: row,
    winCol: col,
    winWidth: width,
    winHeight: winHeight - 2 * BORDER_SIZE,
    previewFloating: true,
    previewSplit: "horizontal",
    // South-east corner of the preview window
    previewRow: row + height,
    previewCol: col,
    previewWidth: width,
    previewHeight: previewHeight - 2 * BORDER_SIZE,
  };
}
