-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- secure native wayland engine optimization for synchronous clipboards
if vim.fn.has("wsl") == 0 and os.getenv("WAYLAND_DISPLAY") ~= nil then
  vim.g.clipboard = {
    name = "wl-clipboard",
    copy = {
      ["+"] = "wl-copy",
      ["*"] = "wl-copy",
    },
    paste = {
      ["+"] = "wl-paste",
      ["*"] = "wl-paste",
    },
    cache_enabled = 1,
  }
end

-- global sync flag initialization
vim.opt.clipboard = "unnamedplus"

-- global sync flag initialization
vim.opt.clipboard = "unnamedplus"

-- user command logic to normalize current buffer layouts
vim.api.nvim_create_user_command("FixIndent", function()
  vim.opt_local.tabstop = 4
  vim.opt_local.shiftwidth = 4
  vim.opt_local.expandtab = true
  vim.cmd("normal! gg=G")
  vim.cmd("normal! ``")
  print("indentation normalized to 4 spaces")
end, {})

-- core operational keystroke map configurations
vim.keymap.set("n", "<leader>t4", "<cmd>FixIndent<cr>", { desc = "force 4 spaces layout" })

-- gitsigns shortcut interface matching base layouts
vim.keymap.set("n", "<leader>uB", function()
  require("gitsigns").toggle_current_line_blame()
end, { desc = "toggle git blame line overlay" })

-- split merge conflict actions away from standard lsp reference shortcuts
vim.keymap.set("n", "<leader>gL", "<cmd>diffget LOCAL<cr>", { desc = "merge: grab local left changes" })
vim.keymap.set("n", "<leader>gR", "<cmd>diffget REMOTE<cr>", { desc = "merge: grab remote right changes" })

-- explicit navigation mappings for git merge targets
vim.keymap.set("n", "<leader>cn", "]c", { desc = "step to next conflict block" })
vim.keymap.set("n", "<leader>cp", "[c", { desc = "step to previous conflict block" })
