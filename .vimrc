set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" set runtime path for fzf and ripgrep integration
set rtp+=~/.fzf
set grepprg=rg\ --vimgrep\ --smart-case\ --follow

" let Vundle manage Vundle, required
Plugin 'urbit/hoon.vim'
Plugin 'https://git.sr.ht/~matthias_schaub/hoon-runes.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"Autocommands
"
"  remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

set bg=dark
set number
set hlsearch
set ruler
set wrap
set nobackup
set shiftwidth=2
set softtabstop=0
set tabstop=2
set expandtab
set incsearch
set tabpagemax=200
set history=1000
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

"Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" Window adjustment
nnoremap st :split<CR>
nnoremap ss :vsplit<CR>
nnoremap t= :10winc ><CR>
nnoremap t- :10winc <<CR>

" fuzzy search
nnoremap <C-f> :FZF ~/dev<CR>
nnoremap <C-f>d :FZF ~/dev<CR>
nnoremap <C-f>o :FZF ~/obsidian/main<CR>

" map <esc> to return to normal mode from terminal mode
tnoremap <esc> <C-\><C-n>
