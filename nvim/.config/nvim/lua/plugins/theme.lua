-- return {
-- 	"navarasu/onedark.nvim",
-- 	priority = 1000,
-- 	config = function()
-- 		vim.cmd.colorscheme("onedark")
-- 	end,
-- }
-- return {
-- 	"folke/tokyonight.nvim",
-- 	priority = 1000,
-- 	config = function()
-- 		vim.cmd.colorscheme("tokyonight")
-- 	end,
-- }
return {
	"Shatur/neovim-ayu",
	main = "ayu",
	init = function()
		vim.opt.termguicolors = true
		vim.cmd.colorscheme("ayu")
	end,
	config = {
		mirage = false, -- Set to true to use mirage variant instead of dark for dark background.
		terminal = false, -- Set to false to let terminal manage its own colors.
		overrides = {}, -- A dictionary of group names, each associated with a dictionary of parameters (bg, fg, sp and style) and colors in hex.
	},
}
