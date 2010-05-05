let mapleader=","

" Indent with 2 spaces. Auto-indent.
set tabstop=2
set smarttab
set shiftwidth=2
set autoindent
set expandtab
set backspace=start,indent

" Layout settings
set t_Co=256 
set number        " turn on line numbers
set cursorline    " highlight current line
set ruler         " show current line/column number in status line
syntax on
colorscheme vividchalk

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" other settings, mostly stolen from bill
set scrolloff=3   " keep 3 lines when scrolling
set vb t_vb=      " turn off error beep/flash
set nobackup      " do not keep a backup file
set noswapfile    " do not make a swap file
set nowritebackup " I mean it do not make a bacukp file ever
set nowrap        " stop lines from wrapping
set wildignore=*.o,*.obj,*.bak,*.exe,*.pyc,*.ds_store,*.db
set ttyfast         " smoother changes

" Make searches case-sensitive only if they contain upper-case characters
set ignorecase
set smartcase

" retain selection after increasing/decreasing indent
vnoremap > >gv
vnoremap < <gv

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

" Manage buffers
noremap <C-left> :bprev<cr>
noremap <C-right> :bnext<cr>
noremap <C-down> :bd<cr>

" FuzzyFinder
map ,t :FufFile<cr>

if has("gui_running")
  set guioptions-=T " hide toolbar

"  " Default to Full screen
"  set fuoptions=maxvert,maxhorz
"  au GUIEnter * set fullscreen

  " no scrollbars no matter what
  set guioptions-=r
  set guioptions-=R
  set guioptions-=l
  set guioptions-=L
endif

