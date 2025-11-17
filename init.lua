--set the leader
vim.g.mapleader = " "

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

--search ignoring case
vim.opt.ignorecase = true

--disable "ignorecase" option if the search pattern contains upper case characters
vim.opt.smartcase = true

--vs code api load
local vscode = require("vscode")

--custom keybindings
--move line vs code
vim.keymap.set({ "n", "v" }, "<A-j>", function()
	vscode.action("editor.action.moveLinesDownAction")
end, {
	desc = "move line down in vs code",
})

vim.keymap.set({ "n", "v" }, "<A-k>", function()
	vscode.action("editor.action.moveLinesUpAction")
end, {
	desc = "move line up in vs code",
})

--search grep (kindof)
vim.keymap.set("n", "<leader>sg", function()
	vscode.action("workbench.action.findInFiles")
end, {
	desc = "grep",
})

--search files
vim.keymap.set("n", "<leader>sf", function()
	vscode.action("workbench.action.quickOpen")
end, {
	desc = "search files in quickOpen",
})

--switch to previous tab
vim.keymap.set("n", "H", function()
	vscode.action("workbench.action.previousEditor")
end, {
	desc = "switch to previous tab",
})

--switch to next tab
vim.keymap.set("n", "L", function()
	vscode.action("workbench.action.nextEditor")
end, {
	desc = "switch to next tab",
})

--editor group navigation(pane navigation)
--move to the right pane
vim.keymap.set("n", "<C-l>", function()
	vscode.action("workbench.action.focusRightGroup")
end, {
	desc = "focus right pane",
})

--move to the left pane
vim.keymap.set("n", "<C-h>", function()
	vscode.action("workbench.action.focusLeftGroup")
end, {
	desc = "focus left pane",
})

--move to the top pane
vim.keymap.set("n", "<C-k>", function()
	vscode.action("workbench.action.focusAboveGroup")
end, {
	desc = "focus above pane",
})

--move to the bottom pane
vscode.action("workbench.action.focusBelowGroup")
vim.keymap.set("n", "<C-j>", function() end, {
	desc = "focus below pane",
})

--code actions(vscode quickfix list)
vim.keymap.set("n", "<leader>ca", function()
	vscode.action("editor.action.quickFix")
end, {
	desc = "open quick fix list",
})

------------------------------------------------

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
require("lazy").setup({
	{
		"ggandor/leap.nvim",
		config = function()
			require("leap").add_default_mappings()
			vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)")
		end,
	},
})
