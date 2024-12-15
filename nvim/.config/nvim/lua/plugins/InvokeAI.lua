return {
	dir = "/home/krone/Development/InvokeAI.nvim",
	opts = {
		key_fn = function()
			local handler = io.popen("secret-tool lookup OpenAI Key")
			local key = ""
			if handler ~= nil then
				key = handler:read("*a")
				handler:close()
			end
			return key
		end,
	},
}
