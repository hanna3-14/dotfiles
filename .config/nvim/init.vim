syntax on
set number
set tabstop=4

call plug#begin("~/.config/nvim/bundle")
" nerdtree with git icons and dev icons
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin' |
            \ Plug 'ryanoasis/vim-devicons'
nnoremap <C-n> :NERDTreeToggle<CR>
call plug#end()
