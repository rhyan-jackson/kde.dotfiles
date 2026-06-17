return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      width = 50,
      mappings = {
        ["l"] = "open",
        ["h"] = "close_node",
      },
    },
    filesystem = {
      follow_current_file = { enabled = true },
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_hidden = true,
      },
    },
  },
}
