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
Plug 'junegunn/vim-plug'                                  " Plugin manager
Plug 'tpope/vim-sensible'
Plug 'junegunn/seoul256.vim'
Plug 'urbit/hoon.vim'                                     " Hoon syntax highlighting
Plug 'https://git.sr.ht/~matthias_schaub/hoon-runes.vim'  " Hoon rune reference
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'                                   " Fuzzy search
Plug 'sheerun/vim-polyglot'                               " Multi-language syntax highlighting
Plug 'majutsushi/tagbar'                                  " Code structure visualization
Plug 'dense-analysis/ale'                                 " Real-time error checking

call plug#end()

" C programming settings
syntax on
filetype plugin indent on

" C specific indentation
autocmd FileType c setlocal tabstop=4 shiftwidth=4 expandtab

" Tagbar settings
nmap <C-t> :TagbarToggle<CR>

" ALE settings for C
let g:ale_linters = {'c': ['gcc', 'clang']}
let g:ale_c_gcc_options = '-Wall -Wextra -Wpedantic'

" AI config
" let g:claude_api_key =
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

" set runtime path for fzf and ripgrep integration
set rtp+=~/.fzf
set grepprg=rg\ --vimgrep\ --smart-case\ --follow

"Autocommands
"
"  remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

"set number
set hlsearch
set number
set relativenumber

"set ruler
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
inoremap 1 !
inoremap 2 @
inoremap 3 #
inoremap 4 $
inoremap 5 %
inoremap 6 ^
inoremap 7 &
inoremap 8 *
inoremap 9 (
inoremap 0 )
" and then the opposite
inoremap ! 1
inoremap @ 2
inoremap # 3
inoremap $ 4
inoremap % 5
inoremap ^ 6
inoremap & 7
inoremap * 8
inoremap ( 9
inoremap ) 0

"
:windo set nodiff

" Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" Window adjustment
nnoremap st :split<CR>
nnoremap ss :vsplit<CR>
nnoremap t= :10winc ><CR>
nnoremap t- :10winc <<CR>

" Insert mode
nnoremap a i
nnoremap ; a

" Line jump
nnoremap 4 0
nnoremap 8 $

" Fuzzy directory search shortcuts
nnoremap ff :FZF ~/<CR>
nnoremap fg :FZF ~/dev<CR>
nnoremap fh :FZF ~/dev-vault/.obsidian/plugins<CR>
nnoremap fn :FZF ~/notes<CR>

" Fuzzy file search shortcuts
nnoremap <C-d> :Ag <CR>

" Map <esc> to return to normal mode from terminal mode
tnoremap <esc> <C-\><C-n>
