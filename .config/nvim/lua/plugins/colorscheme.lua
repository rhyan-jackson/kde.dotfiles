return {
  -- inject the native lua gruvbox engine
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        terminal_colors = true,
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          comments = true,
          operators = false,
          folds = true,
        },
        -- transparent mode allows your native konsole background to bleed through cleanly
        transparent_mode = true,
      })
    end,
  },
  -- force lazyvim to boot with gruvbox instead of tokyonight
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
