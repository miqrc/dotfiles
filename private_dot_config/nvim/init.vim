" BASICS
let mapleader =","
set number relativenumber
set tabstop=4       " width of a TAB char 
set shiftwidth=4    " actual indent size
set expandtab       " spaces instead of tabs
set softtabstop=4   " 4 spaces 

lua require('plugins')
lua require('lsp')
 
" NETRW 
let g:netrw_banner = 0
" Default tree view
let g:netrw_liststyle = 3
" File tree on the left when opening a file with 'v'
let g:netrw_altv=1
" Preview (p) in vertical split
let g:netrw_preview = 1
let g:netrw_winsize = 25

" APPEARANCE

" Truecolor
if (has("termguicolors"))
    set termguicolors
endif

" Enable theme
colorscheme molokai

" Theme contrast corrections
hi Visual  guifg=#000000 guibg=#FFFFFF gui=none
"hi ErrorMsg  guifg=#000000 guibg=#FFFFFF gui=none
hi ErrorMsg   guifg=#1B1D1E guibg=#F92672 gui=bold


" REMAPS
"map <Leader>m :Lexplore<CR>
map <Leader>m :NERDTreeToggle<CR>
map <Leader>n :Files<CR>
imap jj <Esc>
" Redo
map U <C-R>

" CTRL+/ Comment line (NERD Commenter)
nmap <C-_>   <Plug>NERDCommenterToggle
vmap <C-_>   <Plug>NERDCommenterToggle<CR>gv


" STATUS LINE

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline=
set statusline+=%#PmenuSel#
set statusline+=%{FugitiveStatusline()}
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%m
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\ 

