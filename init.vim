" ============================================================================
"  init.vim  —  shared between terminal Neovim and VS Code (vscode-neovim)
"
"  Windows location:  %LOCALAPPDATA%\nvim\init.vim
"                     (i.e. C:\Users\<you>\AppData\Local\nvim\init.vim)
"
"  Everything outside the `if exists('g:vscode')` guard runs in BOTH.
"  Everything inside it only runs when Neovim is embedded in VS Code.
" ============================================================================

" ---------------------------------------------------------------------------
"  1. Text behaviour — safe everywhere
" ---------------------------------------------------------------------------
set ignorecase
set smartcase
set incsearch
set hlsearch
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set history=10000
set nobackup
set nowritebackup
set clipboard=unnamedplus
set sessionoptions-=options
set sessionoptions-=curdir
set sessionoptions+=sesdir

" Your old file set tabstop/shiftwidth=4 for C, then overrode it with 2
" fifty lines later. This actually does what the comment claimed.
augroup indent_by_filetype
  autocmd!
  autocmd FileType c,cpp setlocal shiftwidth=4 softtabstop=4 tabstop=4
augroup END

" ---------------------------------------------------------------------------
"  2. Mappings that are pure text manipulation — safe everywhere
" ---------------------------------------------------------------------------
nnoremap a i
nnoremap ; a

" Trailing whitespace on demand (F5). The BufWritePre autocmd from your old
" config is dropped — VS Code does it on save via files.trimTrailingWhitespace,
" and the autocmd version clobbered your last-search register every write.
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" ---------------------------------------------------------------------------
"  3. VS Code branch
" ---------------------------------------------------------------------------
if exists('g:vscode')

  " --- write / quit --------------------------------------------------------
  " Route through VS Code so its save hooks (format, trim, lint) actually fire.
  nnoremap <silent> KK <Cmd>call VSCodeNotify('workbench.action.files.save')<CR>
  nnoremap <silent> KL <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>

  " --- scrolling -----------------------------------------------------------
  " Neovim's viewport and VS Code's viewport are separate. Using <C-e>/<C-y>
  " here desyncs them; drive VS Code's scroller instead.
  nnoremap <silent> <C-j> <Cmd>call VSCodeNotify('editorScroll', {'to':'down','by':'line','value':10,'revealCursor':v:true})<CR>
  nnoremap <silent> <C-k> <Cmd>call VSCodeNotify('editorScroll', {'to':'up','by':'line','value':10,'revealCursor':v:true})<CR>

  " --- your f-prefix finder muscle memory ----------------------------------
  " ff = fuzzy file open        (was :Files)
  " fg = regex search in files  (was :Rg)
  " fh = recently opened        (was :History)
  " ft = file tree              (was :Fern)
  nnoremap <silent> ff <Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>
  nnoremap <silent> fg <Cmd>call VSCodeNotify('workbench.action.findInFiles')<CR>
  nnoremap <silent> fh <Cmd>call VSCodeNotify('workbench.action.showAllEditorsByMostRecentlyUsed')<CR>
  nnoremap <silent> ft <Cmd>call VSCodeNotify('workbench.view.explorer')<CR>

  " Extras with no fzf.vim equivalent in your old config, same prefix:
  nnoremap <silent> fs <Cmd>call VSCodeNotify('workbench.action.gotoSymbol')<CR>
  nnoremap <silent> fS <Cmd>call VSCodeNotify('workbench.action.showAllSymbols')<CR>
  nnoremap <silent> fc <Cmd>call VSCodeNotify('workbench.action.showCommands')<CR>
  nnoremap <silent> fd <Cmd>call VSCodeNotify('workbench.actions.view.problems')<CR>
  nnoremap <silent> fr <Cmd>call VSCodeNotify('references-view.findReferences')<CR>

  " --- splits --------------------------------------------------------------
  nnoremap <silent> ss <Cmd>call VSCodeNotify('workbench.action.splitEditorRight')<CR>
  nnoremap <silent> st <Cmd>call VSCodeNotify('workbench.action.splitEditorDown')<CR>

  " --- pane sizing (your t= / t-) -----------------------------------------
  " If these error on your VS Code build, fall back to
  " workbench.action.increaseViewSize / decreaseViewSize.
  nnoremap <silent> t= <Cmd>call VSCodeNotify('workbench.action.increaseViewWidth')<CR>
  nnoremap <silent> t- <Cmd>call VSCodeNotify('workbench.action.decreaseViewWidth')<CR>
  nnoremap <silent> t+ <Cmd>call VSCodeNotify('workbench.action.increaseViewHeight')<CR>
  nnoremap <silent> t_ <Cmd>call VSCodeNotify('workbench.action.decreaseViewHeight')<CR>
  nnoremap <silent> t0 <Cmd>call VSCodeNotify('workbench.action.evenEditorWidths')<CR>
  " tmux zoom equivalent:
  nnoremap <silent> tz <Cmd>call VSCodeNotify('workbench.action.toggleMaximizeEditorGroup')<CR>

  " --- moving between editor groups ---------------------------------------
  nnoremap <silent> <C-w>h <Cmd>call VSCodeNotify('workbench.action.navigateLeft')<CR>
  nnoremap <silent> <C-w>j <Cmd>call VSCodeNotify('workbench.action.navigateDown')<CR>
  nnoremap <silent> <C-w>k <Cmd>call VSCodeNotify('workbench.action.navigateUp')<CR>
  nnoremap <silent> <C-w>l <Cmd>call VSCodeNotify('workbench.action.navigateRight')<CR>
  nnoremap <silent> <C-w>q <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>

  " --- panels --------------------------------------------------------------
  nnoremap <silent> <leader>e <Cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>
  nnoremap <silent> <leader>a <Cmd>call VSCodeNotify('workbench.action.toggleAuxiliaryBar')<CR>
  nnoremap <silent> <leader>p <Cmd>call VSCodeNotify('workbench.action.togglePanel')<CR>

  " --- LSP via VS Code, not via a Neovim LSP client ------------------------
  nnoremap <silent> gd <Cmd>call VSCodeNotify('editor.action.revealDefinition')<CR>
  nnoremap <silent> gr <Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>
  nnoremap <silent> gi <Cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>
  nnoremap <silent> gh <Cmd>call VSCodeNotify('editor.action.showHover')<CR>
  nnoremap <silent> <leader>rn <Cmd>call VSCodeNotify('editor.action.rename')<CR>
  nnoremap <silent> <leader>. <Cmd>call VSCodeNotify('editor.action.quickFix')<CR>
  nnoremap <silent> ]d <Cmd>call VSCodeNotify('editor.action.marker.next')<CR>
  nnoremap <silent> [d <Cmd>call VSCodeNotify('editor.action.marker.prev')<CR>

  " Folding is VS Code's, not Neovim's
  nnoremap <silent> zM <Cmd>call VSCodeNotify('editor.foldAll')<CR>
  nnoremap <silent> zR <Cmd>call VSCodeNotify('editor.unfoldAll')<CR>
  nnoremap <silent> za <Cmd>call VSCodeNotify('editor.toggleFold')<CR>

else
  " -------------------------------------------------------------------------
  "  4. Terminal-Neovim-only branch
  "     Rendering, file tree, fuzzy find, syntax, colours — none of this makes
  "     sense inside VS Code, which owns all of it.
  " -------------------------------------------------------------------------
  syntax on
  filetype plugin indent on
  set number
  set relativenumber
  set termguicolors
  set mouse=a
  set wildmenu
  set wrap
  set grepprg=rg\ --vimgrep\ --smart-case\ --follow

  " Your old `hi CursorLine ctermbg=4D436B` was a no-op: cterm colours are
  " 0-255 or names, not hex. This is the working version.
  set cursorline
  set cursorcolumn
  highlight CursorLine   guibg=#4D436B
  highlight CursorColumn guibg=#4D436B

  nnoremap st :split<CR>
  nnoremap ss :vsplit<CR>
  nnoremap t= :10winc ><CR>
  nnoremap t- :10winc <<CR>
  nnoremap KK :w<CR>
  nnoremap KL :q<CR>
  nnoremap <C-j> 10<C-e>
  nnoremap <C-k> 10<C-y>
  tnoremap <esc> <C-\><C-n>

  " fzf / fern / plugin manager block goes here, unchanged from your .vimrc
endif
