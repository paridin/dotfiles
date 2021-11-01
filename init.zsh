# Default to local software
export PATH=$HOME/.local/bin:/usr/local/sbin:$PATH

# set TERM to use 256 colors
export TERM=xterm-256color

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
  export POWERLEVEL9K_CONFIG_FILE=~/.dotfiles/defdo-prompt/p10k.defdo-theme-base.zsh
fi

# Secret configs to add whatever you want in secret mostly for credentials
if [[ -s "${HOME}/.dotfiles/secret.zsh" ]]; then
  source "${HOME}/.dotfiles/secret.zsh"
fi

# When asdf is installed configure it
if [[ (( $+commands[asdf] )) ]]; then
  if [[ -f /opt/homebrew/opt/asdf/asdf.sh ]]; then
    # when asdf is installed via homebrew
    source /opt/homebrew/opt/asdf/asdf.sh
  else
    # default to git usage prefered by me
    source $HOME/.asdf/asdf.sh
  fi

  fpath=(${ASDF_DIR}/completions $fpath)
fi

# Flavour commands for zsh

# prefear usage of exa for ls actions -> brew install exa
if [[ (( $+commands[exa] )) ]]; then
  alias ll="exa -lsnewest"
  alias la="exa -lasnewest"
fi

# prefear usage of bat for cat actions -> brew install bat
if [[ (( $+commands[bat] )) ]]; then
  alias cat="bat"
fi

# Helper functions

# Get the color schema to design the prompt or a theme based on 256 colors
color_shell_schema() {
  for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
}

