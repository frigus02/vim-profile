augroup filetypedetect
	" Git commit message
	autocmd Filetype gitcommit setlocal spell textwidth=72 colorcolumn=73
	" Markdown files work better with spaces
	autocmd Filetype markdown setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
augroup END
