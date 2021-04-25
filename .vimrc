call plug#begin('~/.vim/plugged')

"Plug 'kyoz/purify', { 'rtp': 'vim' }
Plug 'safv12/andromeda.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" Code languages
Plug 'elixir-editors/vim-elixir'
Plug 'neoclide/coc.nvim', {'branch': 'release'}


call plug#end()

" This is required
syntax on
"set background=dark
colorscheme andromeda

set nu

if has('gui_running')
  set guifont=JetBrains\ Mono:h12
endif
