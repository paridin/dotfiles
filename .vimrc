call plug#begin('~/.vim/plugged')

"Plug 'kyoz/purify', { 'rtp': 'vim' }
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" Code languages
Plug 'elixir-editors/vim-elixir'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

"
if has('nvim') || has('termguicolors')
  set termguicolors
endif

" This is required
syntax on
set background=dark
colorscheme challenger_deep

:highlight Normal guifg=#e0e0e0 guibg=#1f1d36 gui=NONE
:highlight NonText guifg=#99968b guibg=#1f1d36 gui=NONE

set nu

if has('gui_running')
  set guifont=JetBrains\ Mono:h12
endif
