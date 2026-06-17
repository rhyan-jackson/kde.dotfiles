return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    -- bubble style separators
    opts.options.component_separators = ""
    opts.options.section_separators = { left = "", right = "" }

    -- custom lsp indicator with gruvbox-styled pill wrapper
    table.insert(opts.sections.lualine_x, 2, {
      function()
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        if #clients == 0 then
          return ""
        end
        local names = {}
        for _, client in ipairs(clients) do
          table.insert(names, client.name)
        end
        return "󰒋 " .. table.concat(names, ", ")
      end,
      separator = { left = "", right = "" },
    })
  end,
}
