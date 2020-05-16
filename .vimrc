set number
set title
set hlsearch
set paste
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set iskeyword+=-
set lcs=tab:>-,trail:+
set list
set viminfo='100,<1000,s1000,h
set complete=kinclude/*/*/*.h,kinclude/*/*\.h,k../../include/*/*/*.h,k../include/*/*/*.h,.,w,b,u,t,kinclude/*/*/*
set noro

nnoremap <C-b> <C-x>
nnoremap <C-x> <C-a>
nnoremap <C-t> :set expandtab!<CR>:%retab!<CR>
"To set special char ^M press: ctrl+v ctrl+m
nnoremap P *0p
vnoremap P *0p

"special char ^M
nnoremap <C-n> :set nu!
nnoremap <C-h> :set noh!
nnoremap <S-y> v$y

"special chars ^[ and ^M
let @x=':set filetype=xml='

autocmd BufWritePre * :%s/\s\+$//e
autocmd BufWritePre * : retab
