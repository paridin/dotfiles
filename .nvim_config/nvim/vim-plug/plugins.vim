call plug#begin('~/.dotfiles/.nvim_config/nvim/autoload/plugged')
" Elixir

"Plug 'kyoz/purify', { 'rtp': 'vim' }

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" Code languages
Plug 'elixir-editors/vim-elixir'

" Auto pairs for '(' '[' '{'
Plug 'jiangmiao/auto-pairs'

" Nord theme
Plug 'arcticicestudio/nord-vim'

" Palenight theme
Plug 'drewtempelmeyer/palenight.vim'

" lightline
Plug 'itchyny/lightline.vim'

" Andromeda
Plug 'safv12/andromeda.vim'

" Challenger deep
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }

" Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Coc Elixir
Plug 'elixir-lsp/coc-elixir'

" Easy Motion
Plug 'easymotion/vim-easymotion'

call plug#end()

function! PluginLoaded(plugin)
  return (isdirectory(g:plug_home . "/" . a:plugin)
  \ && index(keys(g:plugs), a:plugin) >= 0)
endfunction
