let mapleader = "\<Space>"

" ===============================================
" Plugins
" ===============================================
function! PackInit() abort
	packadd minpac

	call minpac#init()
	call minpac#add('k-takata/minpac', { 'type': 'opt' })

	" Format settings
	call minpac#add('tpope/vim-sleuth')

	" Fuzzy finder
	call minpac#add('junegunn/fzf', { 'do': { -> fzf#install() }, 'type': 'opt' })
	call minpac#add('junegunn/fzf.vim', { 'type': 'opt' })

	" Language support
	call minpac#add('neovim/nvim-lspconfig', { 'type': 'opt' })
	call minpac#add('nvim-lua/lsp-status.nvim', { 'type': 'opt' })
	call minpac#add('RRethy/vim-illuminate', { 'type': 'opt' })
	call minpac#add('PProvost/vim-ps1', { 'type': 'opt' })
	call minpac#add('godlygeek/tabular', { 'type': 'opt' })
	call minpac#add('plasticboy/vim-markdown', { 'type': 'opt' })
	call minpac#add('nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate', 'type': 'opt' })
	call minpac#add('nvim-treesitter/nvim-treesitter-textobjects', { 'type': 'opt' })

	" Visual stuff
	call minpac#add('itchyny/lightline.vim', { 'type': 'opt' })
	call minpac#add('dracula/vim', { 'name': 'dracula', 'type': 'opt' })

	" Git
	call minpac#add('tpope/vim-fugitive', { 'type': 'opt' })

	" Navigating
	call minpac#add('tpope/vim-repeat')
	call minpac#add('tpope/vim-unimpaired')
	call minpac#add('tpope/vim-surround')
	call minpac#add('tpope/vim-speeddating')

	" File system
	call minpac#add('tpope/vim-eunuch')

	" Clipboard over SSH
	call minpac#add('ojroques/vim-oscyank', { 'type': 'opt' })
endfunction
command! PackUpdate source $MYVIMRC | call PackInit() | call minpac#update()
command! PackClean source $MYVIMRC | call PackInit() | call minpac#clean()
command! PackStatus packadd minpac | call minpac#status()

" ===============================================
" Neovim default settings (:help nvim-defaults)
" ===============================================
syntax on
filetype plugin indent on
set autoindent
set autoread
set background=dark
set backspace=indent,eol,start
set belloff=all
if &compatible
	set nocompatible
endif
set complete-=i
set cscopeverbose
set display=lastline,msgsep
set encoding=utf-8
set formatoptions=tcqj
set nofsync
set history=10000
set hlsearch
set incsearch
set langnoremap
set nolangremap
set laststatus=2
set nrformats=bin,hex
set ruler
set sessionoptions-=options
set shortmess+=F
set shortmess-=S
set showcmd
set smarttab
set nostartofline
set tabpagemax=50
set ttimeoutlen=50
set ttyfast
set wildmenu
set wildoptions=pum,tagfile

" ===============================================
" Editor settings
" ===============================================
set listchars=tab:▸\ ,space:·
set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
set hidden
set noshowmode
set ignorecase
set smartcase
set scrolloff=2
set sidescrolloff=5
set nojoinspaces
set relativenumber
set number
set mouse=a
set splitbelow
set splitright
set termguicolors
set title
let g:netrw_banner=0
let g:netrw_altv=1
let g:netrw_liststyle=3
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.='\(^\|\s\s\)\zs\.\S\+'

packadd! dracula " see https://github.com/dracula/vim/issues/143#issuecomment-500546548
if exists('$TMUX')
	let g:dracula_colorterm = 0
endif
colorscheme dracula

" Highlight selection on yank
au TextYankPost * silent! lua vim.highlight.on_yank()

" Shortcut for opening files
if has('win32')
	nnoremap <leader>e :e <C-R>=expand("%:h")."\\"<CR>
else
	nnoremap <leader>e :e <C-R>=expand("%:h")."/"<CR>
endif

" Save file
nmap <leader>w :w<CR>

" No arrow keys (force myself to use the home row)
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Open files and folders
if has('win32')
	nmap <leader>project :cd C:\code\
elseif has('osx')
	nmap <leader>project :cd ~/Projects/
	nmap <leader>notes :e ~/Downloads/notes/
endif

" Map keys to make commands usable on a german keyboard
nmap <silent> ö [
nmap <silent> ä ]
nmap <silent> <leader>, <leader>;
