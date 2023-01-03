" Anytime a buffer read or creates a new file with the extension:
" .asm it will format it with the nasm file syntax
" .S it will format it with the asm (gas) file syntax
au BufRead,BufNewFile *.asm set filetype=nasm
au BufRead,BufNewFile *.S set filetype=asm


colorscheme wombat256grf

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set splitbelow
set splitright
set number

