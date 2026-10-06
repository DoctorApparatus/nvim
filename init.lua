-- Set leader key before loading plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.hidden = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.undofile = true

-- 1. Bootstrap lazy.nvim (Automatic installation)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- 2. Setup plugins
require("lazy").setup({
	spec = {
		-- Import all files from ~/.config/nvim/lua/plugins/*.lua
		{ import = "plugins" },
	},
	-- Automatically check for plugin updates
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		-- automatically check for config file changes and reload the ui
		enabled = true, -- default: true
		notify = false, -- get a notification when changes are found
	},
})

vim.cmd("colorscheme cyberdream")

vim.lsp.inlay_hint.enable(true)
vim.opt.clipboard = "unnamedplus"

-- Indentation: tabs, width 4
vim.opt.expandtab = false -- use real tabs, not spaces
vim.opt.tabstop = 4 -- tab displays as 4 spaces wide
vim.opt.shiftwidth = 4 -- >> / << indent by 4
vim.opt.softtabstop = 4 -- <Tab> in insert mode = 4 cols

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "LSP: [G]o to [D]efinition" })

-- Auto-open a bottom terminal split for infrastructure projects
local infra_markers = { "homelab.ini", "hosts.ini", "ansible.cfg", "justfile" }

local function is_infra_project()
	local cwd = vim.uv.cwd()
	for _, marker in ipairs(infra_markers) do
		if vim.uv.fs_stat(cwd .. "/" .. marker) then
			return true
		end
	end
	return false
end

-- Keymap to toggle the bottom terminal (open if closed, close if open)
vim.keymap.set("n", "<leader>tt", function()
	-- Find existing terminal window
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		if vim.bo[buf].buftype == "terminal" then
			vim.api.nvim_win_close(win, false)
			return
		end
	end
	vim.cmd("botright 15split")
	vim.cmd("terminal")
	vim.cmd("wincmd k")
end, { desc = "Toggle bottom terminal" })

-- <leader>tj — jump focus into the terminal window
vim.keymap.set("n", "<leader>tj", function()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		if vim.bo[buf].buftype == "terminal" then
			vim.api.nvim_set_current_win(win)
			vim.cmd("startinsert")
			return
		end
	end
end, { desc = "Jump to terminal" })

-- Escape terminal insert mode with <Esc><Esc>
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

require("markdown")
