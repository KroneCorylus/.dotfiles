local function index_of(items, element)
	local index = -1
	for i, item in ipairs(items) do
		if item == element then
			index = i
			break
		end
	end
	return index
end

local function getNextKeyValuePair(currentKey, myTable)
	local keys = {} -- Store keys in a separate table for easy iteration
	for key, _ in pairs(myTable) do
		table.insert(keys, key)
	end
	table.sort(keys) -- Sort the keys for consistent order
	local currentIndex = 1
	for i, key in ipairs(keys) do
		if key == currentKey then
			currentIndex = i
			break
		end
	end
	local nextIndex = currentIndex % #keys + 1
	local nextKey = keys[nextIndex]
	local nextValue = myTable[nextKey]
	return nextKey
end
local function getPrevKeyValuePair(currentKey, myTable)
	local keys = {}

	for key, _ in pairs(myTable) do
		table.insert(keys, key)
	end

	table.sort(keys)

	local currentIndex = 1

	for i, key in ipairs(keys) do
		if key == currentKey then
			currentIndex = i
			break
		end
	end

	local prevIndex = (currentIndex - 2 + #keys) % #keys + 1
	local prevKey = keys[prevIndex]
	local prevValue = myTable[prevKey]

	return prevKey
end

local function get_relative_dir()
	local plenary = require("plenary")
	local dir = vim.fn.expand("%:p:h")
	return plenary.path:new(dir):make_relative()
end

local function get_relative_file()
	local plenary = require("plenary")
	local file = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
	return plenary.path:new(file):make_relative()
end

local function list_from_folder()
	local harpoon = require("harpoon")
	local relativeDir = get_relative_dir()
	local files = vim.fn.systemlist("ls -p " .. relativeDir .. " | grep -v /")
	for k in pairs(files) do
		local path = relativeDir .. "/" .. files[k]
		harpoon:list(relativeDir):add({ context = { col = 0, row = 1 }, value = path })
	end
	vim.notify("Nueva lista harpoon: " .. relativeDir)
end

local function next_item_in_dir_list()
	local harpoon = require("harpoon")
	local relativeDir = get_relative_dir()
	-- NOTE: No recuerdo para que hice esto... parece no hacer falta
	-- local relativeFile = get_relative_file()
	-- local current_index = index_of(harpoon:list(relativeDir):display(), relativeFile)
	-- harpoon:list(relativeDir)._index = current_index
	harpoon:list(relativeDir):next({ ui_nav_wrap = true })
end

local function prev_item_in_dir_list()
	local harpoon = require("harpoon")
	local relativeDir = get_relative_dir()
	-- NOTE: No recuerdo para que hice esto... parece no hacer falta
	-- local relativeFile = get_relative_file()
	-- local current_index = index_of(harpoon:list(relativeDir):display(), relativeFile)
	-- harpoon:list(relativeDir)._index = current_index
	harpoon:list(relativeDir):prev({ ui_nav_wrap = true })
end

local function show_folder_list()
	local harpoon = require("harpoon")
	local relativeDir = get_relative_dir()
	harpoon.ui:toggle_quick_menu(harpoon:list(relativeDir))
end

local function list_remove()
	local harpoon = require("harpoon")
	local relativeDir = get_relative_dir()
	local harpoonKey = harpoon.config.settings.key()
	harpoon.lists[harpoonKey][relativeDir] = nil
	harpoon.data:update(harpoonKey, relativeDir, nil)
end

local function next_list()
	local harpoon = require("harpoon")
	local harpoonKey = harpoon.config.settings.key()
	local relativeDir = get_relative_dir()
	if harpoon.lists[harpoonKey] ~= nil then
		local next_key = getNextKeyValuePair(relativeDir, harpoon.lists[harpoonKey])
		harpoon:list(next_key):select(harpoon:list(next_key)._index)
		vim.notify("Harpoon list: " .. next_key)
	end
end

local function prev_list()
	local harpoon = require("harpoon")
	local plenary = require("plenary")
	local relativeDir = get_relative_dir()
	local harpoonKey = harpoon.config.settings.key()
	if harpoon.lists[harpoonKey] ~= nil then
		local prev_key = getPrevKeyValuePair(relativeDir, harpoon.lists[harpoonKey])
		harpoon:list(prev_key):select(harpoon:list(prev_key)._index)
		print("Harpoon list: " .. prev_key)
	end
end

return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup({})

		vim.keymap.set("n", "<leader>hf", list_from_folder, { desc = "Create [H]arpoon list from current [F]older." })
		vim.keymap.set("n", "<leader>hd", list_remove, { desc = "[H]arpoon [D]elete current folder list" })
		-- vim.keymap.set("n", "<leader>hx", remove_file_from_list, { desc = 'Harpoon this file from current list' })
		vim.keymap.set("n", "<C-l>", next_list, { desc = "next list" })
		vim.keymap.set("n", "<C-L>", prev_list, { desc = "next list" })
		vim.keymap.set("n", "<C-e>", show_folder_list, { desc = "Show the current directory harpoon list" })
		vim.keymap.set("n", "<C-E>", show_folder_list, { desc = "Show the current directory harpoon list" })
		vim.keymap.set("n", "<Tab>", next_item_in_dir_list, { desc = "next element on list" })
		vim.keymap.set("n", "<S-Tab>", prev_item_in_dir_list, { desc = "prev element on list" })
	end,
}

-- NOTE: comportamiento
-- iniciar harpoon folder al intentar ciclar lista.
-- una manera de crear una lista con todos los archivos de la la carpeta actual
-- una manera de ciclar entre archivos de la lista actual
-- una manera de ciclar entre listas
-- una manera de agregar un archivo a la lista actual
-- una manera de borrar la lista
-- una manera de ver los archivos de la lista
--
--
--
--
-- ciclado de lista cambia la lista actual
-- ciclado de archivo NO cambia la lista actual
--
