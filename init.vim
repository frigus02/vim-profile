let mapleader = "\<Space>"

" ===============================================
" Plugins
" ===============================================
call plug#begin()
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'itchyny/lightline.vim'
Plug 'joshdick/onedark.vim'
Plug 'PProvost/vim-ps1'
call plug#end()

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
set nocompatible
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
colorscheme onedark
set listchars=tab:▸\ ,space:·
set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
set hidden
set noshowmode
set scrolloff=2
set sidescrolloff=5
set nojoinspaces
set relativenumber
set number
set mouse=a
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

" Shortcut for opening files
map <C-p> :Files<CR>
nmap <leader>; :Buffers<CR>

" Save file
nmap <leader>w :w<CR>

" Toggle whitespace
nmap <leader>l :set list!<CR>

" Jump to start and end of line using the home row keys
map H ^
map L $

" No arrow keys (force myself to use the home row)
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Stop highlighting search
vnoremap <C-h> :nohlsearch<cr>
nnoremap <C-h> :nohlsearch<cr>

" Open files and folders
if s:is_win
	nmap <leader>project :cd C:\code\
elseif s:is_mac
	nmap <leader>project :cd ~/Projects/
	nmap <leader>notes :e ~/Downloads/notes/
endif

" Lightline config
let g:lightline={'colorscheme': 'onedark'}

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

" Formatting selected code.
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf <Plug>(coc-fix-current)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
