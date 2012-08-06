"----------------------------------------------------------------------------
" These must be first, because they change other options as a side effect.
"----------------------------------------------------------------------------

" Use Vim settings, rather then Vi settings (much better!).
set nocompatible

let mapleader=","

" pathogen lets keep all our plugins contained in their own directory under
" .vim/bundle. http://github.com/tpope/vim-pathogen
call pathogen#runtime_append_all_bundles()

"----------------------------------------------------------------------------
" Indentation: Tabs are for communists.
"----------------------------------------------------------------------------

set autoindent    " auto indent to same depth as previous line
set smartindent   " and add an indent if needed
set indentexpr="" " but don't reformat stuff I've already indented
" at least I *think* that's what the above is doing...

" 4-space soft tabs
set expandtab
set softtabstop=4
set shiftwidth=4

set textwidth=79

au FileType ruby set softtabstop=2 shiftwidth=2

"----------------------------------------------------------------------------
" Code Folding
"----------------------------------------------------------------------------

set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default

"----------------------------------------------------------------------------
" Layout: I can never decide if I want to roll light on dark or vice versa.
"----------------------------------------------------------------------------

set number        " turn on line numbers
set cursorline    " highlight current line
set ruler         " show current line/column number in status line
set scrolloff=5   " keep 5 lines when scrolling

set nowrap
set t_Co=256
syntax on
set statusline=%F%m%r%h%w\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%l,%v]\ [LEN=%L] 
set laststatus=2
set background=dark

" Turn wrap back on for text files.
" This function is also used elsewhere.
function s:setupWrapping()
  set wrap
  set wm=2
  set textwidth=72
endfunction
au BufRead,BufNewFile *.txt call s:setupWrapping()

" Highlight right margin bg dark gray at 80 chars
set colorcolumn=80
highlight ColorColumn ctermbg=233

"----------------------------------------------------------------------------
" Markdown: set up wrapping and preview. Too slick? Not possible.
"----------------------------------------------------------------------------

function s:setupMarkup()
  call s:setupWrapping()
  map <buffer> <Leader>p :Mm <CR>
endfunction

au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

"----------------------------------------------------------------------------
" Abbreviations: Not as cool as TextMate snippets.
"----------------------------------------------------------------------------

" ERB
:iab <%=   <%= %><Left><Left><Left>
:iab <%   <% %><Left><Left><Left>

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

filetype off " Force filetype to reload for pathogen
filetype plugin indent on

au BufNewFile,BufRead {Gemfile,Rakefile,config.ru} set filetype=ruby
au BufNewFile,BufRead {.txt} set filetype=markdown

"----------------------------------------------------------------------------
" Misc Mappings
"----------------------------------------------------------------------------

" Mimic TextMate's cmd-return (insert newline at end of line regardless of
" cursor position):
imap <D-CR> <C-O>o

" Insert newline above current line
imap <C-CR> <C-O>O

" Use ;; to exit insert mode
imap ;; <Esc>

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

" NERD tree
map <leader>d :NERDTreeToggle<cr>

" copy/paste using system clipboard
" thanks, bill!
map <leader>v "+gP
map <leader>c "+y

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

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
set wildmode=list:longest,list:full
set wildignore=*.o,*.obj,*.bak,*.exe,*.pyc,*.ds_store,*.db,.git,*.rbc,*.class,.svn

" Make searches case-sensitive only if they contain upper-case characters
set ignorecase
set smartcase

" Restore cursor position
if has("autocmd")
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
endif

" Make splits always the same size
set equalalways

" Include user/machine-specific vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

