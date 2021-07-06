lua <<EOF
require'nvim-treesitter.configs'.setup {
	ensure_installed = "maintained",
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
}
EOF
