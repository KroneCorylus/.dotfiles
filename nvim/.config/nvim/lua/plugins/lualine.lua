local function autoformat()
	if vim.g.disable_autoformat then
		return [[]]
	else
		return [[format]]
	end
end
return {
	"nvim-lualine/lualine.nvim",
	opts = {
		options = {
			icons_enabled = false,
			theme = "ayu",
			-- theme = 'onedark',
			component_separators = "|",
			section_separators = "",
		},
		sections = {
			lualine_x = { { autoformat, color = { fg = "#95f542" } }, "encoding", "fileformat", "filetype" },
		},
	},
}
