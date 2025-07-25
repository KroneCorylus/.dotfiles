-- Open file explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
--idk
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

local sqlTradPrompt = [[
Template for each entry:

```sql
INSERT INTO traducciones(grupo, clave) VALUES('<grupo>', '<clave>');
SELECT @idTraduccion = SCOPE_IDENTITY();
 
--es
INSERT INTO traducciones_x_idioma(id_idioma, id_traduccion, texto) VALUES(1, @idTraduccion, '<texto_es>');
--en
INSERT INTO traducciones_x_idioma(id_idioma, id_traduccion, texto) VALUES(2, @idTraduccion, '<texto_en>');
--fr
INSERT INTO traducciones_x_idioma(id_idioma, id_traduccion, texto) VALUES(3, @idTraduccion, '<texto_fr>');
--pt
INSERT INTO traducciones_x_idioma(id_idioma, id_traduccion, texto) VALUES(4, @idTraduccion, '<texto_pt>');

----------------------------------------------------------------------------------------------------------
```

**Instructions:**

* **Text to Translate:** The first line is the text that needs to be translated. Use this for both the key and the main Spanish translation. fix any grammatical error you found.
* **Key Generation:** Generate a key relevant to the text in snake_case.
* **Group Handling:**

  * If a `grupo:` line is present, use it as the group.
  * If no `grupo:` is specified, default to `remplazarGrupo`.
* **Context Handling:** If a `contexto:` line is provided, consider it when selecting translations for more accurate results. For example, "share" can be translated differently based on financial or general context.
* **Response Format:** Only respond with the complete SQL script, no explanations needed.

**Example Input:**

```
Conjunto
grupo: financiamiento
```

**Expected Output:**

```sql
INSERT INTO traducciones(grupo, clave) VALUES('financiamiento', 'conjunto');
SELECT @idTraduccion = SCOPE_IDENTITY();
 
--es
INSERT INTO traducciones_x_idioma(id_idioma, id_traduccion, texto) VALUES(1, @idTraduccion, 'Conjunto');
--en
INSERT INTO traducciones_x_idioma(id_idioma, id_traduccion, texto) VALUES(2, @idTraduccion, 'Set');
--fr
INSERT INTO traducciones_x_idioma(id_idioma, id_traduccion, texto) VALUES(3, @idTraduccion, 'Ensemble');
--pt
INSERT INTO traducciones_x_idioma(id_idioma, id_traduccion, texto) VALUES(4, @idTraduccion, 'Conjunto');
```
**ONLY RESPOND WITH THE SCRIPT** 
Now, generate the script for the following input:
]]

local debugCommentPrompt = [[
add logs to this block of code to debug it. DO NOT CHANGE NOTHING MORE. the log should include the name of the variable being logged and the position, like if entering the function, before return, after some condition, etc
]]

--InvokeAI
vim.keymap.set({ "v", "n" }, "<F5>", function()
	vim.cmd(":w")
	vim.cmd("messages clear")
	require("invokeai").reset()
end, { silent = true })

vim.keymap.set("v", "<Leader>iaa", function()
	require("invokeai").popup()
end, { silent = true, desc = "Ask IA and get response in floating window" })

vim.keymap.set("v", "<Leader>ir", function()
	require("invokeai").popup({ resolve_fn = require("invokeai.resolvers.replace") })
end, { silent = true, desc = "Ask IA as replace" })

vim.keymap.set("v", "<Leader>iat", function()
	require("invokeai").pre_prompt(
		"add the correct type annotations and if the language allow it and some arguments are checked for nulish, remember to set that can be nulish on the types",
		{ resolve_fn = require("invokeai.resolvers.replace") }
	)
end, { silent = true, desc = "Add types" })

vim.keymap.set("v", "<Leader>ias", function()
	require("invokeai").pre_prompt(sqlTradPrompt, { resolve_fn = require("invokeai.resolvers.replace") })
end, { silent = true, desc = "Generate a traducciones sql script" })

vim.keymap.set("v", "<Leader>iac", function()
	require("invokeai").pre_prompt(debugCommentPrompt, { resolve_fn = require("invokeai.resolvers.replace") })
end, { silent = true, desc = "Generate comments to debug" })

vim.keymap.set("v", "<Leader>ial", function()
	require("invokeai").pre_prompt(
		"only add type annotations in LuaCATS format",
		{ resolve_fn = require("invokeai.resolvers.replace") }
	)
end, { silent = true, desc = "Add types lua" })
