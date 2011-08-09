" -----------------------------------------------------------
"  GRAPHICAL
" -----------------------------------------------------------
"
winpos 0 0

set gfn=DejaVu\ Sans\ Mono:h13
set anti               " antialiasing
set guioptions=gemc
"set guioptions=aAce
"set guioptions-=T " hide toolbar
set columns=100
set lines=61
set ch=4
set guifont=Inconsolata:h13
set transparency=8

" puts external commands through a pipe instead of a pseudo-tty:
" set noguipty

" put the * register on the system clipboard
set clipboard+=unnamed

" set color scheme
colorscheme vividchalk

" -----------------------------------------------------------
"  TABS
" -----------------------------------------------------------
"
set guitablabel=%N\ %t\ %m

" C-TAB and C-SHIFT-TAB cycle tabs forward and backward
nmap <c-tab> :tabnext<cr>
imap <c-tab> <c-o>:tabnext<cr>
vmap <c-tab> <c-o>:tabnext<cr>
nmap <c-s-tab> :tabprevious<cr>
imap <c-s-tab> <c-o>:tabprevious<cr>
vmap <c-s-tab> <c-o>:tabprevious<cr>

" C-# switches to tab
nmap <d-1> 1gt
nmap <d-2> 2gt
nmap <d-3> 3gt
nmap <d-4> 4gt
nmap <d-5> 5gt
nmap <d-6> 6gt
nmap <d-7> 7gt
nmap <d-8> 8gt
nmap <d-9> 9gt

" -----------------------------------------------------------
"  Highlight Trailing Whitespace
" -----------------------------------------------------------
"
highlight SpecialKey    guifg=#222222 guibg=#000000
highlight StatusLineNC  guifg=#444444 guibg=#222222
highlight StatusLine    guifg=#AAAACC guibg=#222222
