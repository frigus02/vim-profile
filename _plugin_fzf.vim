packadd fzf
packadd fzf.vim

" Preview for fzf
function! s:win_preview()
	return {'options': ['--preview', 'powershell -NoProfile -File '.stdpath('config').'\scripts\preview.ps1 {}']}
endfunction
if has('win32')
	command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, s:win_preview(), <bang>0)
	command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, s:win_preview(), <bang>0)
endif

" Shortcut for opening files
nmap <C-p> :Files<CR>
nmap <leader>; :Buffers<CR>
