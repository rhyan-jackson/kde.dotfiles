return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      python = { "isort", "black" },
      c = { "clang-format" },
      cpp = { "clang-format" },
      sh = { "shfmt" },
      bash = { "shfmt" },
      tex = { "latexindent" },
      java = { "google-java-format" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
}
