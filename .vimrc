"""""""""""""""""""""""""""""
"" Maintainer: Kent Sommer ""
"""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
"" Contents:                ""
""   - vim-plug             ""
""   - General              ""
""   - User interface       ""
""   - Colors and fonts     ""
""   - Files and backups    ""
""   - Text, tab and indent ""
""   - Visual mode          ""
""   - Movement             ""
""   - Mappings             ""
""   - Spell check          ""
""   - Misc                 ""
""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""
"" vim-plug ""
""""""""""""""

"" Auto install
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | :so $MYVIMRC | :q
endif

"" Set plugin directory
call plug#begin('~/.vim/plugged')

"" vim-solarized8 (color theme)
Plug 'lifepillar/vim-solarized8'

"" yapf (Google's Python Code formatter)
Plug 'google/yapf', { 'rtp': 'plugins/vim', 'for': 'python' }

"" vim-airline (better status bar)
Plug 'vim-airline/vim-airline'

"" vim-airline themes (status bar themes)
Plug 'vim-airline/vim-airline-themes'

"" vim-evanesco (nicer search)
Plug 'pgdouyon/vim-evanesco'

"" vim-surround (easily delete, change, and add surroundings in pairs)
Plug 'tpope/vim-surround'

"" vim-repeat (improved . command)
Plug 'tpope/vim-repeat'

"" vim-commentary (Comment stuff out...)
Plug 'tpope/vim-commentary'

"" nerdtree (tree explorer)
Plug 'scrooloose/nerdtree'

"" vimtex (modern latex plugin)
Plug 'lervag/vimtex'

"" fzf (fuzzy finder)
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"" Initialize plugin system
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""
"" General ""
"""""""""""""

"" How many lines of history to remember
set history=500

"" Set to auto read when a file is changed externally
set autoread

"" Set the mapleader. If "mapleader" is not set or empty, a backslash is used instead.
let mapleader = ","

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""
"" User interface ""
""""""""""""""""""""

"" Set scrolloff (how many lines above and below cursor should be visible)
set so=10

"" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

"" Always show current position
set ruler

"" Set command bar height
set cmdheight=2

"" Hide a buffer when it is abandoned
set hid

"" Enable backspace to delete over line breaks
set backspace=eol,start,indent

"" Ignore case when searching
set ignorecase

"" Set match upper case if upper else match lower and upper
set smartcase

"" Don't redraw while running macros
set lazyredraw

"" Make regex characters have the same meaning as in grep
set magic

"" Show matching brackets (and blink timing in tenths of a second)
set showmatch
set mat=2

"" Add a small margin to the left
set foldcolumn=1

"" Toggle line numbers
nmap <C-l><C-l> :set invnumber<CR>

"" Add space to listchars
set listchars+=space:•

"" Toggle list
noremap <F5> :set list!<CR>
inoremap <F5> <C-o>:set list!<CR>
cnoremap <F5> <C-c>:set list!<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""
"" Colors and fonts ""
""""""""""""""""""""""

"" Set color scheme
let g:solarized_use16 = 1
set background=dark
silent! colorscheme solarized8

"" Set vim-airline theme
let g:airline_theme='badwolf'

"" Set standard encoding to UTF-8
set encoding=utf8

"" Set standard file type to Unix
set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""
"" Files and backups ""
"""""""""""""""""""""""

"" Turn backups off (use git instead...)
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""
"" Text, tab and indent ""
""""""""""""""""""""""""""

"" Spaces instead of tabs (sorry richard)
set expandtab

"" Enable smarttab (and settings)
set smarttab
set shiftwidth=4
set tabstop=4

"" Enable auto indenting
filetype indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""
"" Visual mode ""
"""""""""""""""""

"" Search for currently selected text using * or # (when in visual mode)
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""
"" Movement ""
""""""""""""""

"" Map <space> to / (search) and ctrl-<space> to ? (backwards search)
map <space> /
map <c-@> ?

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""
"" Mappings ""
""""""""""""""

"" Set <0> to move to first NON-BLANK character
map 0 ^

"" yapf auto format whole file (ctrl+<y>)
map <C-Y> ggvG$:call yapf#YAPF()<cr>

"" yapf auto format current buffer
map <C-B> :call yapf#YAPF()<cr>

"" Toggle for NerdTree
map <C-N> :NERDTreeToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""
"" Spell check ""
"""""""""""""""""

"" Set ss to toggle spell checking
map <leader>ss :setlocal spell!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""
"" Misc ""
""""""""""

"" Delete trailing white space on save
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun
