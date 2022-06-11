return {
    settings = {
		Lua = {
			diagnostics = {
                globals = { "vim" },    -- to make neovim library usable
            },
            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                },
            },
		},
	},
}
