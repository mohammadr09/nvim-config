-- nvim configruation
-- author: Mohammad Rahman (mohammadr09)

-- Defaults & Globals
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set softtabstop=2")
vim.g.mapleader = " "
vim.opt.number = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  { "catppuccin/nvim", name="catppuccin", prioirty=1000 },
  { "nvim-telescope/telescope.nvim", tag="0.1.5",
    dependencies={ "nvim-lua/plenary.nvim" }
  },
  { "nvim-treesitter/nvim-treesitter", build=":TSUpdate"},
  -- File Icons
  { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },
}
local opts = {}

require("lazy").setup(plugins, opts)
local builtin = require("telescope.builtin")

-- Treesitter Config
local config = require("nvim-treesitter.configs")
config.setup({
  ensure_installed = {"lua", "javascript", "cpp", "c", "java", "typescript", "html", "css", "python", "json"},
  highlight = { enable = true },
  indent = { enable = true }
})

-- File Explorerer Configs
require("nvim-tree").setup({
  sort_by="name",
  view={ width=30, side="left" },
  renderer = { icons = { show = { file = true, folder = true, folder_arrow = true } } },
})

-- Keybinds --
vim.keymap.set("n", "<leader>p", builtin.find_files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>g", builtin.live_grep, { desc = "Grep Files" })
vim.keymap.set("n", "<leader>f", ":NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })

require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"


