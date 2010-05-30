
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

let mapleader=","

" Indent with 2 spaces. Auto-indent.
set tabstop=2
set smarttab
set shiftwidth=2
set autoindent
set smartindent
set expandtab

" Layout settings
set t_Co=256 
set number        " turn on line numbers
set cursorline    " highlight current line
set ruler         " show current line/column number in status line
syntax on
colorscheme vividchalk
set statusline=%F%m%r\ %y\ [%l/%L\ %v]

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Remap the tab key to do autocompletion or indentation depending on the
" context (from http://bitbucket.org/garybernhardt/dotfiles/src/tip/.vimrc)
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" other settings, mostly stolen from bill
set scrolloff=5   " keep 3 lines when scrolling
set vb t_vb=      " turn off error beep/flash
set nobackup      " do not keep a backup file
set noswapfile    " do not make a swap file
set nowritebackup " I mean it do not make a bacukp file ever
set nowrap        " stop lines from wrapping
set wildignore=*.o,*.obj,*.bak,*.exe,*.pyc,*.ds_store,*.db
set ttyfast         " smoother changes
set wildmenu
set ls=2            " allways show status line

" Make searches case-sensitive only if they contain upper-case characters
set ignorecase
set smartcase

" retain selection after increasing/decreasing indent
vmap > >gv
vmap < <gv

" copy/paste
map ,p "+gp
map ,y "+y

" Toggle NERDTree
map ,d :execute 'NERDTreeToggle ' . getcwd()<cr>

" Updating .vimrc
map ,ve :vs ~/.vimrc<cr>
map ,vu :source ~/.vimrc<cr>:exe ":echo 'vimrc reloaded'"<cr>

" Viewport controls
map ,h <C-w>h
map ,j <C-w>j
map ,k <C-w>k
map ,l <C-w>l

" Run current file
map ,rr :w<cr>:!ruby %<cr>
map ,rp :w<cr>:!python %<cr>

" Turn off search highlights
map <C-n> :noh<cr>

" FuzzyFinder
" Recursive hack from http://intraspirit.net/scratchpad/a-simple-fuzzyfinder-improvement/
map ,t :FufFileRecursive<cr>

" ShowFunc plugin
map ,f <Plug>ShowFunc

if has("gui_running")
  set guioptions-=T " hide toolbar

"  " Default to Full screen
  set fuoptions=maxvert,maxhorz
  au GUIEnter * set fullscreen

  " no scrollbars no matter what
  set guioptions-=r
  set guioptions-=R
  set guioptions-=l
  set guioptions-=L
endif

" Abbreviations for ERB
:iab erif  <% if %><Left><Left><Left>
:iab erend <% end %><c-d>
:iab <%=   <%= %><Left><Left><Left>

" Abbreviations for cucumber
:iab fea 
\Feature: 
\<CR>  In order
\<CR>As a 
\<CR>I want <Up><Up><Right><Right>

" Abbreviations for ruby
:iab def 
\def
\<CR>end<Up>

" Custom filetypes
filetype on
au BufNewFile,BufRead *.ru set filetype=ruby

