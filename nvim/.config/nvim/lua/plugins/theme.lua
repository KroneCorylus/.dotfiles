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
	"catppuccin/nvim",
	main = "catppuccin",
	init = function()
		vim.opt.termguicolors = true
		vim.cmd.colorscheme("catppuccin")
	end,
	config = {
		flavour = "mocha",
		color_overrides = {
			mocha = {
				rosewater = "#F5B8AB",
				flamingo = "#F29D9D",
				pink = "#AD6FF7",
				mauve = "#FF8F40",
				red = "#E66767",
				maroon = "#EB788B",
				peach = "#FAB770",
				yellow = "#FACA64",
				green = "#70CF67",
				teal = "#4CD4BD",
				sky = "#61BDFF",
				sapphire = "#4BA8FA",
				blue = "#00BFFF",
				lavender = "#00BBCC",
				text = "#C1C9E6",
				subtext1 = "#A3AAC2",
				subtext0 = "#8E94AB",
				overlay2 = "#7D8296",
				overlay1 = "#676B80",
				overlay0 = "#464957",
				surface2 = "#3A3D4A",
				surface1 = "#2F313D",
				surface0 = "#1D1E29",
				base = "#0b0e14",
				mantle = "#11111a",
				crust = "#191926",
			},
		},
	},
}
-- return {
-- 	"Shatur/neovim-ayu",
-- 	main = "ayu",
-- 	init = function()
-- 		vim.opt.termguicolors = true
-- 		vim.cmd.colorscheme("ayu")
-- 	end,
-- 	config = {
-- 		mirage = false, -- Set to true to use mirage variant instead of dark for dark background.
-- 		terminal = false, -- Set to false to let terminal manage its own colors.
-- 		overrides = {
-- 			Function = { fg = "#5CCFE6" },
-- 			Identifier = { fg = "#e3ff73" },
-- 			StorageClass = { fg = "#e3ff73" },
-- 			Typedef = { fg = "#e3ff73" },
-- 			Type = { fg = "#e3ff73" },
-- 			["@property"] = { fg = "#e3ff73" },
-- 		}, -- A dictionary of group names, each associated with a dictionary of parameters (bg, fg, sp and style) and colors in hex.
-- 	},
-- }
