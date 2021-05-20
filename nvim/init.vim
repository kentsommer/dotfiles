"""""""""""""""""""""""""""""
"" Maintainer: Kent Sommer ""
"""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
"" Contents:                ""
""   - vim-plug             ""
""   - lsp                  ""
""   - fzf                  ""
""   - vim-clang-format     ""
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

"" Auto install vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | :so $MYVIMRC | :q
endif

if !executable("yarn")
  silent !curl -o- -L https://yarnpkg.com/install.sh | bash
endif

if !executable("nodejs")
  silent !curl -sL install-node.now.sh/lts | bash
endif

"" Set plugin directory
call plug#begin()

"" vim-solarized8 (color theme)
Plug 'lifepillar/vim-solarized8'

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

"" fzf (fuzzy finder)
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"" vim-clang-format
Plug 'rhysd/vim-clang-format'

"" coc (lsp)
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

"" Initialize plugin system
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""
"" lsp ""
"""""""""

"" Highlight symbol under cursor on CursorHold
autocmd CursorMoved * silent call CocActionAsync('highlight')

"" Mapping for running a CodeAction
nmap <silent> ma <Plug>(coc-codeaction-selected)<CR>

"" Mapping for GoTo Definition/Declaration
nmap <silent> md <Plug>(coc-definition)

"" Mapping for Rename
nmap <silent> mr <Plug>(coc-rename)

"" Mapping for Type Definition
nmap <silent> mt <Plug>(coc-type-definition)

"" Mapping for code folding
nmap <silent> mc <Plug>(coc-action-fold)

"" Mapping for Hover
nmap <silent> mh :call CocAction('doHover')<CR>

"" Mapping for Switch Header/Source
nmap <silent><nowait> ms :CocCommand clangd.switchSourceHeader<CR>

"" Mapping for Symbolinfo
nmap <silent><nowait> mi :CocCommand clangd.symbolInfo<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""
"" fzf ""
"""""""""

"" Remap ESC for fzf so that it exits the search pane when pressed.
autocmd FileType fzf tnoremap <buffer> <Esc> <Esc>

"" Mapping for file search pane.
nmap <silent> mo :GFiles<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""
"" vim-clang-format ""
""""""""""""""""""""""

 "" Set base style
let g:clang_format#code_style = "google"

 "" Set extra style options
let g:clang_format#style_options = {"ColumnLimit" : 120,
                                  \ "DerivePointerAlignment" : "false",
                                  \ "PointerAlignment" : "Left"}

"" Manually select specific clang-format version
" let g:clang_format#command = "/opt/tri/llvm/9.0.1/bin/clang-format"
let g:clang_format#command = "/home/kentsommer/source_installs/system/llvm-project/build/bin/clang-format"

 "" Turn on clang-format on buffer write by default
let g:clang_format#auto_format = 1

 "" Toggle clang-format formatting on buffer write
nmap mf :ClangFormatAutoToggle<CR>

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

"" Mapping to open vertical split fish terminal
nmap <silent> me :vsp term://fish<CR>

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

"" Always show signcolumns
set signcolumn=yes

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

"" Make ESC exit terminal mode
tnoremap <Esc> <C-\><C-n>

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

function! s:gotobuild() abort
    let l:file_path=@%
    let l:file_name=split(l:file_path, '/')[-1]
    let l:file_directory=trim(system('dirname ' . l:file_path))
    let l:worktree=trim(system("git -C " . l:file_directory . " rev-parse --show-toplevel"))
    if l:worktree =~ "fatal: not a git repository"
      echo "Doing nothing, not in a git repository"
      return
    endif
    " Use ripgrep if available else grep.
    if executable('rg')
      let l:command="rg --multiline 'srcs = \\[(?s).*" . l:file_name . "\"' --glob 'BUILD' --vimgrep " . l:worktree . " |tail -1"
    else
      let l:command="grep -r '\"" . l:file_name . "\"' " . l:worktree . " -n --include 'BUILD'"
    endif
    echo l:command
    let l:result=trim(system(l:command))
    if l:result == ""
      echo 'No corresponding BUILD file found'
    else
      let l:result_list=split(l:result, ':')
      let l:build_file_name=l:result_list[0]
      let l:build_file_line=l:result_list[1]
      execute 'edit +' . l:build_file_line l:build_file_name
      execute 'normal! zz'
    endif
endfunction
command! -complete=command GOTOBuild call <SID>gotobuild()
nnoremap <silent> mB :GOTOBuild<CR>
