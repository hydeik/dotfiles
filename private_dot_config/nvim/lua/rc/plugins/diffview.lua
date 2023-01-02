-- Single tabpage interface for easily cycling through diffs for all modified files for any git rev.
return {
  "sindrets/diffview.nvim",
  cmd = {
    "DiffviewOpen",
    "DiffviewFileHistory",
    "DiffviewClose",
    "DiffviewToggleFiles",
    "DiffviewRefresh",
    "DiffviewLog",
  },
  config = true,
}
