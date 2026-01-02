packadd nvim-treesitter
packadd nvim-treesitter-textobjects

lua <<EOF
require'nvim-treesitter'.setup {
	highlight = {
		enable = true,
		disable = { "yaml" },
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gss",
			node_incremental = "gsi",
			scope_incremental = "gsp",
			node_decremental = "gsd",
		},
	},
	indent = {
		enable = true,
	},
	textobjects = {
		select = {
			enable = true,
			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
			},
		},
	},
}
EOF
