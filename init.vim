let mapleader = "\<Space>"

" ===============================================
" Plugins
" ===============================================
function! PackInit() abort
	packadd minpac

	call minpac#init()
	call minpac#add('k-takata/minpac', { 'type': 'opt' })

	" Format settings
	call minpac#add('editorconfig/editorconfig-vim')

	" Fuzzy finder
	call minpac#add('junegunn/fzf', { 'do': { -> fzf#install() } })
	call minpac#add('junegunn/fzf.vim')

	" Language support
	call minpac#add('neoclide/coc.nvim', { 'branch': 'release' })
	call minpac#add('PProvost/vim-ps1')
	call minpac#add('godlygeek/tabular')
	call minpac#add('plasticboy/vim-markdown')
	call minpac#add('cespare/vim-toml')
	call minpac#add('leafgarland/typescript-vim')
	call minpac#add('peitalin/vim-jsx-typescript')
	call minpac#add('udalov/kotlin-vim')

	" Visual stuff
	call minpac#add('itchyny/lightline.vim')
	call minpac#add('dracula/vim', { 'name': 'dracula' })
	call minpac#add('machakann/vim-highlightedyank')

	" Git
	call minpac#add('tpope/vim-fugitive')

	" Navigating
	call minpac#add('tpope/vim-repeat')
	call minpac#add('tpope/vim-unimpaired')
	call minpac#add('tpope/vim-surround')
	call minpac#add('vim-scripts/argtextobj.vim')
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
packadd! dracula " see https://github.com/dracula/vim/issues/143#issuecomment-500546548
colorscheme dracula
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

" OS detection
let s:is_win = has('win32')
let s:is_mac = has('osx') " or: gui_mac, mac, macunix, osxdarwin

" Preview for fzf
function! s:win_preview()
	return {'options': ['--preview', 'powershell -NoProfile -File '.stdpath('config').'\scripts\preview.ps1 {}']}
endfunction
if s:is_win
	command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, s:win_preview(), <bang>0)
	command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, s:win_preview(), <bang>0)
endif

" Markdown
let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_folding_style_pythonic = 1

" Shortcut for opening files
nmap <C-p> :Files<CR>
nmap <leader>; :Buffers<CR>
if s:is_win
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
if s:is_win
	nmap <leader>project :cd C:\code\
elseif s:is_mac
	nmap <leader>project :cd ~/Projects/
	nmap <leader>notes :e ~/Downloads/notes/
endif

" Lightline config
let g:lightline = {
	\ 'colorscheme': 'dracula',
	\ 'active': {
	\   'left': [ [ 'mode', 'paste' ],
	\             [ 'gitbranch', 'cocstatus', 'readonly', 'relativepath', 'modified' ] ]
	\ },
	\ 'component_function': {
	\   'gitbranch': 'FugitiveHead',
	\   'cocstatus': 'coc#status',
	\ },
	\ }

" ===============================================
" Recommended for coc.nvim
" ===============================================
" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
	inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
	imap <expr> <cr> pumvisible() ? "\<C-y>" : \<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf <Plug>(coc-fix-current)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
nmap <leader>f :Format<CR>

" Map keys to make commands usable on a german keyboard
nmap <silent> ö [
nmap <silent> ä ]
nmap <silent> <leader>, <leader>;
