packadd nvim-lspconfig
packadd lsp-status.nvim
packadd vim-illuminate

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Delay highlight idendifier under cursor (in milliseconds).
let g:Illuminate_delay = 300

lua <<EOF
local lspconfig = require('lspconfig')
local illuminate = require('illuminate')
local lsp_status = require('lsp-status')
local opts = { noremap=true, silent=true }

lsp_status.register_progress()

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.api.nvim_set_keymap('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

vim.api.nvim_set_keymap('n', '[h', '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<CR>', opts)
vim.api.nvim_set_keymap('n', ']h', '<cmd>lua require"illuminate".next_reference{wrap=true}<CR>', opts)

local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

	illuminate.on_attach(client)
	lsp_status.on_attach(client)
end

lspconfig.tsserver.setup({
	capabilities = lsp_status.capabilities,
	on_attach = on_attach,
})
lspconfig.rust_analyzer.setup({
	capabilities = lsp_status.capabilities,
	on_attach = on_attach,
	settings = { ["rust-analyzer"] = { checkOnSave = { command = "clippy" } } },
})
EOF
