"----------------------------------------------------------------------------
" These must be first, because they change other options as a side effect.
"----------------------------------------------------------------------------

" Use Vim settings, rather then Vi settings
set nocompatible

let mapleader=","

"----------------------------------------------------------------------------
" Set up Vundle: https://github.com/gmarik/vundle
" see :h vundle for more details or wiki for FAQ
"----------------------------------------------------------------------------

filetype off " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Note: comments after Bundle command are not allowed..

" Vundle is required for vundle!
"
" Normally this would come first, but I'm keeping
" vundle under version control so I don't to clone it
" separately in addition to my dotfiles.
"
" Bundle 'gmarik/vundle'

" my bundles:
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'mattn/gist-vim'
Bundle 'kien/ctrlp.vim'
Bundle 'groenewege/vim-less'
Bundle 'othree/html5.vim'
Bundle 'vim-scripts/EasyGrep'
Bundle 'nono/vim-handlebars'
Bundle 'majutsushi/tagbar'

" required for gist-vim:
Bundle 'mattn/webapi-vim'

filetype plugin indent on " required!

"----------------------------------------------------------------------------
" Indentation:
"----------------------------------------------------------------------------

set autoindent " default indentation to that of the previous line
filetype plugin indent on " enable filetype-based special indentation rules

" 4-space soft tabs by default
set expandtab
set softtabstop=4
set shiftwidth=4

" 2-spaces for some things
au FileType ruby,cucumber,haml,coffee,js,json,yaml set softtabstop=2 shiftwidth=2

"----------------------------------------------------------------------------
" Layout:
"----------------------------------------------------------------------------

syntax on         " enable syntax highlighting
set nowrap        " disable line wrapping by default
set number        " turn on line numbers
set cursorline    " highlight current line
set ruler         " show current line/column number in status line
set scrolloff=5   " keep 5 lines when scrolling
set t_Co=256      " use 256 colors
set laststatus=2  " always show the status line

" Status line has filepath + modified flag, then file type, ascii and hex
" codes for character under cursor, and cursor row/column position.
set statusline=%F%m\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%l,%v] 

" Use Gary Bernhardt's custom DAS theme:
" https://github.com/garybernhardt/dotfiles/blob/master/.vim/colors/grb256.vim
" High contrast without having offensive colors. Perfect for my sucky eyes.
" Especially nice using the Pastel color set with a large font in iTerm 2.
color grb256
set background=dark

" Highlight right margin bg dark gray at 80 chars
set colorcolumn=80
highlight ColorColumn ctermbg=233

" Don't unerline html links. Looks crazy in django/rails templates.
hi link htmlLink NONE

"----------------------------------------------------------------------------
" Autocomplete: I should really expand on these...
"----------------------------------------------------------------------------

" Close ERB tags
:iab <%=   <%= %><Left><Left><Left>
:iab <%   <% %><Left><Left><Left>

" Close html tags by typing </ and hitting space
:iab </ </<C-x><C-o>

"----------------------------------------------------------------------------
" Set Custom Filetypes
"----------------------------------------------------------------------------

au BufNewFile,BufRead {Gemfile,Rakefile,Guardfile,config.ru} set filetype=ruby
au BufNewFile,BufRead {*.hbs} set filetype=handlebars
au BufNewFile,BufReadPost {*.md} set filetype=markdown
au BufNewFile,BufRead {*.liquid} set filetype=html

"---------------------------------------------------------------------------
" Configure plugins
"---------------------------------------------------------------------------

" Gist: https://github.com/mattn/gist-vim
let g:gist_post_private = 1 " private by default

" CtrlP
map <leader>t :CtrlPClearAllCaches<cr>:CtrlP<cr>

" NERD tree
map <leader>f :NERDTreeFind<cr>
map <leader>d :NERDTreeToggle<cr>
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\.pyc$']

" Tagbar (like NERD tree but for ctags)
map <leader>m :TagbarToggle<cr>

" EasyGrep
let EasyGrepRecursive=1
let EasyGrepSearchCurrentBufferDir=0

" Buffet.vim
map <leader>b :Bufferlist<cr>

"----------------------------------------------------------------------------
" Misc Mappings
"----------------------------------------------------------------------------

" Updating .vimrc
map <leader>ve :e ~/.vimrc<cr>
map <leader>vu :source ~/.vimrc<cr>:exe ":echo 'vimrc reloaded'"<cr>

" Opens an edit command with the path of the currently edited file filled in
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

"----------------------------------------------------------------------------
" Misc Settings
"----------------------------------------------------------------------------

" Hide buffers instead of closing them.
" This lets me switch buffers without saving,
" and maintains undo history.
set hidden

" Highlight search results.
set hlsearch

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

if has("autocmd")
  " Restore cursor position
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  " Strip trailing whitespace on save
  autocmd FileType python,ruby autocmd BufWritePre <buffer> :%s/\s\+$//e
endif

" Make splits always the same size
set equalalways

" Include user/machine-specific vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

" Change cursor shape in different modes.
" Options:
" 1 or 0 -> blinking block
" 2 -> solid block
" 3 -> blinking underscore
" 4 -> underscore
" 5 -> blinking vertical bar
" 6 -> solid vertical bar
let &t_SI .= "\<Esc>[6 q" " solid vertical bar in insert mode
let &t_EI .= "\<Esc>[2 q" " solid block in normal mode

"-----------------------------------------------------------------------------
" Gui Settings
"-----------------------------------------------------------------------------
if has("gui_running")

    " use a big font and hide the toolbar
    set guifont=Monaco:h14
    set guioptions-=T

endif
