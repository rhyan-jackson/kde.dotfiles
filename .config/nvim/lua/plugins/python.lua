return {
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
    },
    lazy = false,
    keys = {
      { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "select python virtual environment" },
    },
    config = function()
      -- suppress strict lua language server type warnings
      ---@diagnostic disable-next-line: missing-fields
      require("venv-selector").setup({
        settings = {
          options = {
            notify_user_on_venv_activation = true,
          },
        },
      })
    end,
  },
}
