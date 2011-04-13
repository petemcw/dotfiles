" ---------------------------------------------------------------------------
" General
" ---------------------------------------------------------------------------

" Setup pathogen plugin for bundles
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set nocompatible                      " essential
set history=1000                      " lots of command line history
set cf                                " error files / jumping
set ffs=unix,dos,mac                  " support these files
filetype plugin indent on             " load filetype plugin
set isk+=_,$,@,%,#,-                  " none word dividers
set viminfo='1000,f1,:100,@100,/20
set modeline                          " make sure modeline support is enabled
set autoread                          " reload files (no local changes only)
set tabpagemax=50                     " open 50 tabs max

" ---------------------------------------------------------------------------
" Colors / Theme
" ---------------------------------------------------------------------------

if &t_Co > 2 || has("gui_running")
    if has("terminfo")
        set t_Co=256
    endif
    syntax on
    set hlsearch
    colorscheme ir_black
endif

" ---------------------------------------------------------------------------
"  Highlight
" ---------------------------------------------------------------------------

highlight Comment         ctermfg=DarkGrey guifg=#444444
highlight StatusLineNC    ctermfg=Black ctermbg=DarkGrey cterm=bold
highlight StatusLine      ctermbg=Black ctermfg=LightGrey

" ----------------------------------------------------------------------------
"   Highlight Trailing Whitespace
" ----------------------------------------------------------------------------

set list listchars=tab:▸\ ,eol:¬
highlight SpecialKey ctermfg=DarkGray ctermbg=Black

" ----------------------------------------------------------------------------
"  Backups
" ----------------------------------------------------------------------------

set backupskip=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*
set directory=~/.vim/swap,~/tmp,.      " keep swp files under ~/.vim/swap

" ----------------------------------------------------------------------------
"  UI
" ----------------------------------------------------------------------------

set ruler                  " show the cursor position all the time
set showcmd                " display incomplete commands
set nolazyredraw           " turn off lazy redraw
set number                 " line numbers
set numberwidth=5
set wildmenu               " turn on wild menu
set wildmode=list:longest,full
set ch=2                   " command line height
set backspace=2            " allow backspacing over everything in insert mode
set whichwrap+=<,>,h,l,[,] " backspace and cursor keys wrap to
set shortmess=filtIoOA     " shorten messages
set report=0               " tell us about changes
set nostartofline          " don't jump to the start of line when scrolling

" ----------------------------------------------------------------------------
" Visual Cues
" ----------------------------------------------------------------------------

set showmatch              " brackets/braces that is
set mat=5                  " duration to show matching brace (1/10 sec)
set incsearch              " do incremental searching
set laststatus=2           " always show the status line
set ignorecase             " ignore case when searching
set nohlsearch             " don't highlight searches
set visualbell             " shut the fuck up

" ----------------------------------------------------------------------------
" Text Formatting
" ----------------------------------------------------------------------------

set autoindent             " automatic indent new lines
set smartindent            " be smart about it
set nowrap                 " do not wrap lines
set softtabstop=4          " yep, four
set shiftwidth=4           " ....
set tabstop=4
set expandtab              " expand tabs to spaces
set nosmarttab             " fuck tabs
set formatoptions+=n       " support for numbered/bullet lists
set textwidth=80           " wrap at 80 chars by default
set virtualedit=block      " allow virtual edit in visual block ..

" ----------------------------------------------------------------------------
"  Mappings
" ----------------------------------------------------------------------------

" CTags
map ,rt :!ctags --extra=+f -R *<CR><CR>

" quickfix mappings
map <F7>  :cn<CR>
map <S-F7> :cp<CR>
map <A-F7> :copen<CR>

" Replicate Text Mate's indent/outdent
nmap <D-[> <<
nmap <D-]> >>
vmap <D-[> <gv
vmap <D-]> >gv

" command-t
noremap ,t :CommandT<CR>
noremap ,4 :Ack <cword><CR>

" ack

" reflow paragraph with Q in normal and visual mode
nnoremap Q gqap
vnoremap Q gq

" sane movement with wrap turned on
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" do not menu with left / right in command line
cnoremap <Left> <Space><BS><Left>
cnoremap <Right> <Space><BS><Right>

" \ is the leader character
let mapleader = ","

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>


" ----------------------------------------------------------------------------
"  Auto Commands
" ----------------------------------------------------------------------------

" jump to last position of buffer when opening
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |
                         \ exe "normal g'\"" | endif

" don't use cindent for javascript
autocmd FileType javascript setlocal nocindent

" ----------------------------------------------------------------------------
"  LookupFile
" ----------------------------------------------------------------------------

let g:LookupFile_TagExpr = '".ftags"'
let g:LookupFile_MinPatLength = 2
let g:LookupFile_ShowFiller = 0                  " fix menu flashiness
let g:LookupFile_PreservePatternHistory = 1      " preserve sorted history?
let g:LookupFile_PreserveLastPattern = 0         " start with last pattern?

nmap <unique> <silent> <D-f> <Plug>LookupFile
imap <unique> <silent> <D-f> <C-O><Plug>LookupFile

" ----------------------------------------------------------------------------
"  PATH on MacOS X
" ----------------------------------------------------------------------------

if system('uname') =~ 'Darwin'
  let $PATH = $HOME .
    \ '/usr/local/bin:/usr/local/sbin:' .
    \ '/usr/pkg/bin:' .
    \ '/opt/local/bin:/opt/local/sbin:' .
    \ $PATH
endif

" ---------------------------------------------------------------------------
"  sh config
" ---------------------------------------------------------------------------

au Filetype sh,bash set ts=4 sts=4 sw=4 expandtab
let g:is_bash = 1

" ---------------------------------------------------------------------------
"  Misc mappings
" ---------------------------------------------------------------------------

map ,f :tabnew <cfile><CR>
map ,d :e %:h/<CR>
map ,dt :tabnew %:h/<CR>

" ---------------------------------------------------------------------------
"  Open URL on current line in browser
" ---------------------------------------------------------------------------

function! Browser ()
    let line0 = getline (".")
    let line = matchstr (line0, "http[^ )]*")
    let line = escape (line, "#?&;|%")
    exec ':silent !open ' . "\"" . line . "\""
endfunction
map ,w :call Browser ()<CR>

" ---------------------------------------------------------------------------
"  Strip all trailing whitespace in file
" ---------------------------------------------------------------------------

function! StripWhitespace ()
    exec ':%s/ \+$//gc'
endfunction
map ,s :call StripWhitespace ()<CR>

" ---------------------------------------------------------------------------
" File Types
" ---------------------------------------------------------------------------

au BufRead,BufNewFile *.go         set ft=go
au BufRead,BufNewFile *.mustache   set ft=mustache
au BufRead,BufNewFile *.rpdf       set ft=ruby
au BufRead,BufNewFile *.rxls       set ft=ruby
au BufRead,BufNewFile *.ru         set ft=ruby
au BufRead,BufNewFile *.god        set ft=ruby
au BufRead,BufNewFile *.rtxt       set ft=html spell
au BufRead,BufNewFile *.sql        set ft=pgsql
au BufRead,BufNewFile *.rl         set ft=ragel
au BufRead,BufNewFile *.svg        set ft=svg
au BufRead,BufNewFile *.haml       set ft=haml
au BufRead,BufNewFile *.md         set ft=mkd tw=80 ts=2 sw=2 expandtab
au BufRead,BufNewFile *.markdown   set ft=mkd tw=80 ts=2 sw=2 expandtab
au BufRead,BufNewFile *.ronn       set ft=mkd tw=80 ts=2 sw=2 expandtab

au Filetype gitcommit set tw=68  spell
au Filetype ruby      set tw=80  ts=2
au Filetype html,xml,xsl,rhtml source $HOME/.vim/scripts/closetag.vim

au BufNewFile,BufRead *.mustache        setf mustache

" --------------------------------------------------------------------------
" ManPageView
" --------------------------------------------------------------------------

let g:manpageview_pgm= 'man -P "/usr/bin/less -is"'
let $MANPAGER = '/usr/bin/less -is'

" make file executable
command -nargs=* Xe !chmod +x <args>
command! -nargs=0 Xe !chmod +x %
