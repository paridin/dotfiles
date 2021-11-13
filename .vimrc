syntax enable
set shell=/bin/zsh

set number
"set mouse=a
set numberwidth=1
" set clipboard=unnamed
" backspace https://stackoverflow.com/questions/18777705/vim-whats-the-default-backspace-behavior
set backspace=indent,eol,start

packloadall

if (has("termguicolors"))
  set termguicolors
endif

if !has('gui_running')
  set t_Co=256
  set guifont=JetBrains\ Mono\ 12
endif

set noerrorbells
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch

set colorcolumn=120
highlight ColorColumn ctermbg=0 guibg=lightgrey

set showcmd
set ruler
set encoding=utf8
set showmatch
set sw=2
set relativenumber
set laststatus=2
set noshowmode

let mapleader=" "


" coc + coc-elixir
if PluginLoaded('coc.nvim')
  source $HOME/.dotfiles/.coc.config
  
  let g:coc_global_extensions = [ 'coc-elixir' ]
  
  nmap <Leader>gd <Plug>(coc-definition)
  nmap <Leader>gr <Plug>(coc-references)
  nmap <Leader>gi <Plug>(coc-implementation)
  nmap <Leader>gy <Plug>(coc-type-definition)
endif

" fzf
if isdirectory("/usr/local/opt/fzf")
  set rtp+=/usr/local/opt/fzf  
endif

if PluginLoaded("lightline")
  " To enable the lightline theme
  let g:lightline#bufferline#show_number  = 1
  let g:lightline#bufferline#shorten_path = 0
  let g:lightline#bufferline#unnamed      = '[No Name]'
  "let g:lightline.active = { 'left': [ [ 'mode', 'paste' ], [ 'gitbranch', 'readonly', 'filename', 'modified' ] ] }
  "let g:lightline.component = { 'lineinfo': ' %3l:%-2v' }
  "let g:lightline.component_function = { 'gitbranch': 'gitbranch#name' }
  "let g:lightline.separator = { 'left': '', 'right': '' }
  "let g:lightline.subseparator = { 'left': '', 'right': '' }
endif

if PluginLoaded('nord-vim')
  set background=dark
  colorscheme nord

  if PluginLoaded('lightline.vim')
   let g:lightline = { 'colorscheme': 'nord' }
  endif
endif

if PluginLoaded('palenight.vim')
  set background=dark
  colorscheme palenight

  if PluginLoaded('lightline.vim')
    let g:lightline = { 'colorscheme': 'palenight' }
  endif
endif

" easy-motion
if exists('g:EasyMotion_loaded')
  echo "easymotion"
  nmap <Leader>s <Plug>(easymotion-s2)
  nmap <Leader>w :w<CR>
  nmap <Leader>q :q<CR>
  nmap <Leader>x :x<CR>
  nmap <Leader>gs :CocSearch
  nmap <Leader>fs :Files<CR>
endif


" nnoremap <C-p> :GFiles<C
 :imap ii <Esc

" nvim
if has('nvim') || has('termguicolors')
  set termguicolors
endif

" This is required
syntax on
set background=dark

if has('nvim') || has('termguicolors')
  set termguicolors
endif

:highlight Normal guifg=#e0e0e0 guibg=#1f1d36 gui=NONE
:highlight NonText guifg=#99968b guibg=#1f1d36 gui=NONE

set nu

if has('gui_running')
  set guifont=JetBrains\ Mono:h12
endif
