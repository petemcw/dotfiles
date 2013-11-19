" Not vi-compatible
set nocompatible

" ----------------------------------------
" Vundle
" ----------------------------------------
source $HOME/.vim-bundles

" ----------------------------------------
" Settings
" ----------------------------------------

" Use UTF-8 as the default buffer encoding
set enc=utf-8

" Do not wrap lines
set nowrap

" Show line numbers
set number

" Allow backspacing over everything
set backspace=indent,eol,start

" Use 4 spaces for (auto)indent
set shiftwidth=4

" Use 4 spaces for <Tab> and :retab
set tabstop=4
set softtabstop=4

" Expand tabs to spaces
set expandtab

" Right margin to use when wrapping text
"set textwidth=72

" Enable incremental search
set incsearch

" Do not highlight results of a search
set nohlsearch

" Clear highlighted search
nmap <silent> <leader>/ :nohlsearch<CR>

" Ignore case when searching
set ignorecase

" Show line, column number, and relative position within a file in the status line
set ruler

" Indenting
set autoindent

" Show (partial) commands (or size of selection in Visual mode) in the status line
set showcmd

" Use menu to show command-line completion (in 'full' case)
set wildmenu

" Set command-line completion mode:
"   - on first <Tab>, when more than one match, list all matches and complete
"     the longest common  string
"   - on second <Tab>, complete the next full match and show menu
set wildmode=list:longest,full

" Ignore certain types of files on completion
set wildignore+=*.o,*.obj,*.pyc,.git,*.bak,.svn

" Change the mapleader from \ to ,
let mapleader=","

" Hide buffers instead of closing - multiple files, one window
set hidden

" Remember up to 1000 'colon' commmands and search patterns
set history=1000

" When a bracket is inserted, briefly jump to a matching one
set showmatch

" Jump to matching bracket for 2/10th of a second (works with showmatch)
set matchtime=2

" Changes up/down to move by line in editor
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Switch windows with Ctrl + a movement key
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Quickly open the vim config file in a new tab.
nmap <leader>v :tabedit $MYVIMRC<CR>

" Show hidden characters
set list listchars=tab:>·,trail:·,nbsp:.,eol:¬

" Rapidly toggle 'set list'
nmap <leader>l :set list!<CR>

" Remap ':' to ';' - Saves two strokes
nnoremap ; :

" Forget sudo?
cmap w!! w !sudo tee % >/dev/null

" Key for paste mode
set pastetoggle=<F2>

" Use <F6> to toggle line numbers
nmap <silent> <F6> :set number!<CR>

" Page down with <Space>
nmap <Space> <PageDown>

" Highight the active cursor line
set cursorline

" Colors
syntax enable
let g:solarized_termtrans=1
set background=dark
colorscheme solarized

" Enable filetype detection
if has("autocmd")
    filetype plugin indent on
endif

" File Types
if has("autocmd")
    autocmd BufRead,BufNewFile {*.sql}                                  set ft=pgsql
    autocmd BufRead,BufNewFile {*.haml}                                 set ft=haml
    autocmd BufRead,BufNewFile {*.rss,*.atom}                           set ft=xml
    autocmd BufRead,BufNewFile {Gemfile,Rakefile,Capfile,*.rake,*.ru}   set ft=ruby
    autocmd BufRead,BufNewFile {*.md,*.mkd,*.markdown}                  set ft=markdown
    autocmd BufRead,BufNewFile {COMMIT_EDITMSG}                         set ft=gitcommit
endif

" Indentation
if has("autocmd")
    autocmd FileType sh,bash setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType php setlocal ts=4 sts=4 sw=4 expandtab
    autocmd Filetype ruby setlocal tw=80 ts=2 sts=2 sw=2 expandtab
    autocmd FileType html setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType javascript setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType css setlocal ts=4 sts=4 sw=4 expandtab
endif

" Markdown
if has("autocmd")
    autocmd FileType markdown set wrap
    autocmd FileType markdown set linebreak
endif

" Web
if has("autocmd")
    autocmd FileType haml set nowrap
    autocmd FileType sass set textwidth=0
endif

" Editing
if has("autocmd")
    " Strip trailing white space on specific files
    autocmd BufWritePre *.php,*.phtml,*.rb,*.htm,*.html,*.css,*.py,*.js :%s/\s\+$//ge

    " Go back to the position the cursor was on the last time this file was edited
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")|execute("normal `\"")|endif
endif

" PHP
if has("autocmd")
    " Highlight interpolated variables in SQL strings & SQL-syntax highlighting
    autocmd FileType php let php_sql_query=1

    " Highlight HTML inside of PHP strings
    autocmd FileType php let php_htmlInStrings=1

    " Discourages use of short tags.
    autocmd FileType php let php_noShortTags=1
endif
