# Default to local software
export PATH=$HOME/.local/bin:/usr/local/sbin:$PATH

# When brew exists, use it adding to the path
if [[ (( $+commands[brew] )) ]]; then
  source ${HOME}/.dotfiles/paridin-prompt/paridin-prompt.zsh-theme
  export PATH=$PATH:/opt/homebrew/bin
fi

# When zimfw is installed use the paridin-prompt as default theme  
if [[ (( $+commands[zimfw] )) ]]; then
  source ${HOME}/.dotfiles/paridin-prompt/paridin-prompt.zsh-theme
fi

# Theme for p10k
if [[ (( $+commands[p10k] )) ]]; then
  # default themej
  # export POWERLEVEL9K_CONFIG_FILE=~/.dotfiles/defdo-prompt/p10k.defdo-theme-base.zsh
  # export POWERLEVEL9K_CONFIG_FILE=~/.dotfiles/defdo-prompt/p10k.defdo-theme-base.zsh
  # hallowen theme
  export POWERLEVEL9K_CONFIG_FILE=~/.dotfiles/defdo-prompt/p10k.defdo-theme-halloween.zsh
fi

# Secret configs to add whatever you want in secret mostly for credentials
if [[ -s "${HOME}/.dotfiles/secret.zsh" ]]; then
  source "${HOME}/.dotfiles/secret.zsh"
fi

# When asdf is installed configure it
if [[ -f ~/.asdf/asdf.sh ]]; then
  source ~/.asdf/asdf.sh
  fpath=(${ASDF_DIR}/completions $fpath)
fi

# Flavour commands for zsh

# prefear usage of exa for ls actions -> brew install exa
if [[ (( $+commands[exa] )) ]]; then
  alias l="exa --tree -L 1 --icons"
  alias ll="exa --tree -L 1 -lsnewest --icons"
  alias la="exa --tree -L 1 -lasnewest --icons"
fi

# prefear usage of bat for cat actions -> brew install bat
if [[ (( $+commands[bat] )) ]]; then
  alias cat="bat"
fi

eval "$(jump shell)"

if [[ (( $+commands[tree] )) ]]; then
  t() {
    local _level=${1:-1}
    tree . -L $_level --gitignore -d --metafirst --info -D -t
  }
fi

# Helper functions

# Get the color schema to design the prompt or a theme based on 256 colors
color_shell_schema() {
  for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
}

if type vim >/dev/null 2>/dev/null; then
  alias vi=vim
fi

# Set nvim config if it is installed
if type nvim >/dev/null 2>/dev/null; then
  setup_nvim() {
    ln -s $HOME/.dotfiles/.nvim_config/nvim $HOME/.config/nvim
  }

  alias vim=nvim
  alias nvimplugins="nvim $HOME/.dotfiles/.nvim_config/nvim/vim-plug/plugins.vim"
  alias nviminit="nvim $HOME/.dotfiles/.nvim_config/nvim/init.vim"
fi

install_deps_raspi_os() {
  sudo apt update
  # git
  sudo apt install git
  # vim, nvim
  sudo apt install vim snapd
  sudo snap install core
  sudo snap install nvim --classic
  # asdf
  # exa
  sudo apt install exa
  # bat a cat alternative
  BAT_VERSION=0.18.3
  wget https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/bat_${BAT_VERSION}_arm64.deb && sudo dpkg -i bat_${BAT_VERSION}_arm64.deb
}
