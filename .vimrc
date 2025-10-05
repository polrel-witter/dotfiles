set nocompatible
filetype off

" Plug, plugin manager init
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')
" Plugins
Plug 'junegunn/vim-plug'  " Plugin manager
Plug 'tpope/vim-sensible'
Plug 'junegunn/seoul256.vim'
Plug 'urbit/hoon.vim'  " Hoon syntax highlighting
Plug 'https://git.sr.ht/~matthias_schaub/hoon-runes.vim'  " Hoon rune reference
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }  " Fuzzy search
Plug 'junegunn/fzf.vim'  " Fuzzy search
Plug 'sheerun/vim-polyglot'  " Multi-language syntax highlighting
Plug 'lambdalisue/vim-fern'  " File tree viewer
" Plug 'dense-analysis/ale'  " Real-time error checking

call plug#end()

" C programming settings
syntax on
filetype plugin indent on

" Indentation
set tabstop=4
set shiftwidth=4
set expandtab

" ALE settings for C
let g:ale_linters = {'c': ['gcc', 'clang']}
let g:ale_c_gcc_options = '-Wall -Wextra -Wpedantic'

" LLM config
" Installation instructions: https://github.com/pasky/claude.vim
let g:claude_api_key = ''
let g:claude_map_implement = "gci"
let g:claude_map_open_chat = "gcc"
let g:claude_map_send_chat_message = "g]"
let g:claude_map_cancel_response = "gcx"

" Brief help
"
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Set runtime path for fzf and ripgrep integration
set rtp+=~/.fzf
set grepprg=rg\ --vimgrep\ --smart-case\ --follow

" Remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

" Numbers
set hlsearch
set number
set relativenumber

" Ruler
set wrap
set nobackup
set shiftwidth=2
set softtabstop=0
set tabstop=2
set expandtab
set incsearch
set tabpagemax=200
set history=10000
set wildmenu
set clipboard=unnamedplus

set sessionoptions-=options
set sessionoptions-=curdir
set sessionoptions+=sesdir

" Mouse scrolling
set mouse=a
set scroll=1
nnoremap <C-j> 10<C-e>
nnoremap <C-k> 10<C-y>

" Cursor
hi CursorLine cterm=NONE ctermbg=4D436B
hi CursorColumn cterm=NONE ctermbg=4D436B
au WinEnter * set cursorline
au WinEnter * set cursorcolumn
au WinLeave * set nocursorline
au WinLeave * set nocursorcolumn
au InsertEnter * hi CursorLine cterm=underline
au InsertLeave * hi CursorLine cterm=NONE

" Key Bindings
" map each number to its shift-key character
" inoremap 1 !
" inoremap 2 @
" inoremap 3 #
" inoremap 4 $
" inoremap 5 %
" inoremap 6 ^
" inoremap 7 &
" inoremap 8 *
" inoremap 9 (
" inoremap 0 )
" and then the opposite
" inoremap ! 1
" inoremap @ 2
" inoremap # 3
" inoremap $ 4
" inoremap % 5
" inoremap ^ 6
" inoremap & 7
" inoremap * 8
" inoremap ( 9
" inoremap ) 0

" Map <esc> to return to normal mode from terminal mode
tnoremap <esc> <C-\><C-n>

" Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" Window adjustment
nnoremap st :split<CR>
nnoremap ss :vsplit<CR>
nnoremap t= :10winc ><CR>
nnoremap t- :10winc <<CR>

" Write/Quit
nnoremap KK :w<CR>
nnoremap KL :q<CR>

" Insert mode
nnoremap a i
nnoremap ; a

"Search
nnoremap <silent> ff :Files<CR>
nnoremap <silent> ft :Fern .<CR>
nnoremap <silent> fg :Rg<CR>
nnoremap <silent> fh :History<CR>
