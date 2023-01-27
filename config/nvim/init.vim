call plug#begin('~/.local/share/nvim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim'
Plug 'jiangmiao/auto-pairs'
Plug 'gruvbox-community/gruvbox'
Plug 'preservim/nerdtree'
call plug#end ()

" Configurations
syntax on
set ts=2 sts=2 sw=2 et si
set rnu
"set title
"set guioptions-=T
"set ignorecase
"set smartcase
"set incsearch
"set shortmess+=I
"set autoindent
set number
set noswapfile
"set relativenumber
set encoding=utf-8
set scrolloff=2
"set hidden 
"set nowrap
"set nojoinspaces
set mouse+=a
"set laststatus=2
set spelllang=es,en
set tabstop=2
set shiftwidth=2
set expandtab
set ai
set hlsearch
set ruler
highlight Comment ctermfg=green

let g:lightline = {
  \ 'colorscheme': 'apprentice',
   \ }


"colorscheme
set termguicolors
colo gruvbox

"nerdtree config
inoremap <c-x> <Esc>:NERDTreeToggle<cr>
nnoremap <c-x> <Esc>:NERDTreeToggle<cr>

""completion for coc
" use <tab> to trigger completion and navigate to the next complete item
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>

inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
noremap <Down>  <ESC>:echoe "Use j"<CR>

