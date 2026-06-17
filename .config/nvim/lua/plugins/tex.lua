return {
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      -- bind to zathura for native wayland synctex support
      vim.g.vimtex_view_method = "zathura"

      -- enable unicode concealment for math symbols (hides messy slash commands)
      vim.g.tex_conceal = "abdmg"
      vim.opt.conceallevel = 2

      -- configure continuous background compilation engine
      vim.g.vimtex_compiler_latexmk = {
        build_dir = "",
        callback = 1,
        continuous = 1,
        executable = "latexmk",
        options = {
          "-pdf",
          "-shell-escape",
          "-verbose",
          "-file-line-error",
          "-synctex=1",
          "-interaction=nonstopmode",
        },
      }

      -- prevent quickfix from aggressively stealing focus on minor warnings
      vim.g.vimtex_quickfix_open_on_warning = 0
    end,
  },
}
