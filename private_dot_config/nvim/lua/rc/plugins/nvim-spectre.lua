return {
  -- search/replace in multiple files
  "nvim-pack/nvim-spectre",
  keys = {
    {
      "<Space>sr",
      function()
        require("spectre").open()
      end,
      desc = "Replace in files (Spectre)",
    },
  },
}
