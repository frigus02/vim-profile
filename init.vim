" Shell
if has("win32")
	set shell=cmd.exe
	set shellcmdflag=/c\ powershell.exe\ -NoLogo\ -NoProfile\ -NonInteractive
	set shellpipe=|
	set shellredir=>
endif

" Editor settings
source nvim-defaults.vim
set listchars=tab:▸\ ,space:·
set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
set hidden
set scrolloff=2
set sidescrolloff=5
set nojoinspaces
