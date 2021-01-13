augroup filetypedetect
	" Git commit message
	autocmd FileType gitcommit let b:EditorConfig_disable
	autocmd FileType gitcommit setlocal spell textwidth=72 colorcolumn=73
	" Markdown files work better with spaces
	autocmd FileType markdown setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
	" YAML files work better with spaces
	autocmd FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
augroup END
