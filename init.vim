"""""""""""""""""""""""""""""
"" Maintainer: Kent Sommer ""
"""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
"" Contents:                ""
""   - vim-plug             ""
""   - vim-lsc              ""
""   - clang-format         ""
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
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | :so $MYVIMRC | :q
endif

"" Set plugin directory
call plug#begin()

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

"" vim-gitgutter (git integration)
Plug 'airblade/vim-gitgutter'

"" nerdtree (tree explorer)
Plug 'scrooloose/nerdtree'

"" vimtex (modern latex plugin)
Plug 'lervag/vimtex'

"" fzf (fuzzy finder)
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"" async (normalize commands between neovim and vim)
Plug 'prabirshrestha/async.vim'

"" asyncomplete (async completion engine)
Plug 'prabirshrestha/asyncomplete.vim'

"" asyncomplete-lsp (lsp support for asyncomplete)
Plug 'prabirshrestha/asyncomplete-lsp.vim'

"" vim-lsc (language server client)
Plug 'prabirshrestha/vim-lsp'
 
"" vim-clang-format
Plug 'rhysd/vim-clang-format'

"" vim-clang-format
Plug 'rhysd/vim-clang-format'

"" Initialize plugin system
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""
"" vim-lsp ""
"""""""""""""

"" Enable signs (warnings, info, etc)
let g:lsp_signs_enabled = 1

"" Enable diagnostics
let g:lsp_diagnostics_enabled = 1

"" Set sign for errors
let g:lsp_signs_error = {'text': '✗'}

"" Set sign for warning
let g:lsp_signs_warning = {'text': '⚠'}

"" Set sign for hint/info
let g:lsp_signs_hint = {'text': 'Ⓘ'}

"" Show diagnostics under cursor in normal mode
let g:lsp_diagnostics_echo_cursor = 1

"" Use async completion
let g:lsp_async_completion = 1

"" Mapping for Rename
nnoremap mR :LspRename<CR>

"" Mapping for GoTo Definition
nnoremap md :LspDefinition<CR>

"" Mapping for GoTo Declaration
nnoremap mD :LspDeclaration<CR>

"" Mapping for running a CodeAction
nnoremap ma :LspCodeAction<CR>

"" Mapping for Format
nnoremap mf :LspDocumentFormat<CR>

"" Mapping for visual selection Format
vnoremap mf :LspDocumentRangeFormat<CR>

"" Mapping for show Document Symbol
nnoremap mS :LspDocumentSymbol<CR>

"" Mapping for showing Implementation of Interface
nnoremap mI :LspImplementation<CR>

"" Mapping for Find References
nnoremap mr :LspReferences<CR>

"" Mapping for Type Definition
nnoremap mT :LspTypeDefinition<CR>

"" Mapping for search/show Workspace Symbol
nnoremap ms :LspWorkspaceSymbol<CR>

"" Show preview while typing
let asyncomplete_auto_completeopt = 0
set completeopt=menuone,noinsert,noselect,preview

"" Setup clangd integration
if executable('clangd')
   au User lsp_setup call lsp#register_server({
       \ 'name': 'clangd',
       \ 'cmd': {server_info->['/home/kentsommer/Software/source_installs/llvm-project/build/bin/clangd']},
       \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
       \ })
endif

"" Setup python integration
" if executable('pyls')
"    au User lsp_setup call lsp#register_server({
"        \ 'name': 'pyls',
"        \ 'cmd': {server_info->['pyls']},
"        \ 'whitelist': ['python'],
"        \ 'workspace_config': {'pyls': {'plugins': {'pydocstyle': {'enabled': v:true}}}}
"        \ })
" endif

"" Key binding setup
imap <c-space> <Plug>(asyncomplete_force_refresh)
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

"" Debug logging
let g:lsp_log_verbose = 0
let g:lsp_log_file = expand('~/vim-lsp.log')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""
"" clang-format ""
""""""""""""""""""

"" Set base style
let g:clang_format#code_style = "google"

"" Set extra style options
let g:clang_format#style_options = {"ColumnLimit" : 120,
                                  \ "DerivePointerAlignment" : "false",
                                  \ "PointerAlignment" : "Left"}

"" Manually select specific clang-format version
let g:clang_format#command = "clang-format-6.0"

"" Turn on clang-format on buffer write by default
let g:clang_format#auto_format = 1

"" Toggle clang-format formatting on buffer write
nmap <Leader>C :ClangFormatAutoToggle<CR>

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

"" Fix stupid bug
set guicursor=

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
set shiftwidth=2
set tabstop=2

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
