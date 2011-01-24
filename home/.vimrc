"----------------------------------------------------------------------------
" These must be first, because they change other options as a side effect.
"----------------------------------------------------------------------------

" Use Vim settings, rather then Vi settings (much better!).
set nocompatible

let mapleader=","

"----------------------------------------------------------------------------
" Indentation: 2 spaces is where it's at! Tabs are for communists.
"----------------------------------------------------------------------------

set tabstop=2
set smarttab
set shiftwidth=2
set autoindent
set smartindent
set expandtab

"----------------------------------------------------------------------------
" Layout: I can never decide if I want to roll light on dark or vice versa.
"----------------------------------------------------------------------------

set number        " turn on line numbers
set cursorline    " highlight current line
set ruler         " show current line/column number in status line
set scrolloff=5   " keep 5 lines when scrolling

set nowrap
syntax on
set statusline=%F%m%r\ %y\ [%l/%L\ %v]

"----------------------------------------------------------------------------
" Abbreviations: Not as cool as TextMate snippets.
"----------------------------------------------------------------------------

" ERB
:iab eri <% if %><Left><Left><Left>
:iab eru <% unless %><Left><Left><Left>
:iab ere <% end %><c-d>
:iab <%=   <%= %><Left><Left><Left>

" cucumber
:iab fea 
\Feature: 
\<CR>  In order to
\<CR>As a 
\<CR>I want to <Up><Up><Right><Right>

" ruby
:iab def 
\def
\<CR>end<Up>

"----------------------------------------------------------------------------
" Auto-complete: TextMate WISHES it could do this!
"----------------------------------------------------------------------------

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

"----------------------------------------------------------------------------
" Custom Filetypes
"----------------------------------------------------------------------------

filetype on

au BufNewFile,BufRead *.ru set filetype=ruby " rackup files are ruby

"----------------------------------------------------------------------------
" Misc Mappings
"----------------------------------------------------------------------------

" Updating .vimrc
map <leader>ve :vs ~/.vimrc<cr>
map <leader>vu :source ~/.vimrc<cr>:exe ":echo 'vimrc reloaded'"<cr>

" Viewport controls
map <leader>h <C-w>h
map <leader>j <C-w>j
map <leader>k <C-w>k
map <leader>l <C-w>l

" Run current file
map <leader>rr :w<cr>:!ruby %<cr>
map <leader>rp :w<cr>:!python %<cr>

" Toggle spellcheck
map <leader>s :set spell!<cr>

" retain selection after increasing/decreasing indent
vmap > >gv
vmap < <gv

"----------------------------------------------------------------------------
" Misc Settings
"----------------------------------------------------------------------------

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" turn off error beep/flash
set vb t_vb=

" never make a backup file ever
set nobackup      
set noswapfile    
set nowritebackup 

" smoother changes
set ttyfast

" enable wildmenu
set wildmenu
set wildignore=*.o,*.obj,*.bak,*.exe,*.pyc,*.ds_store,*.db

" Make searches case-sensitive only if they contain upper-case characters
set ignorecase
set smartcase
