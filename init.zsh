source ${HOME}/.dotfiles/paridin-prompt/paridin-prompt.zsh-theme

export PATH=$HOME/.local/bin:/opt/homebrew/bin:/usr/local/sbin:$PATH:/Users/paridin/Library/Python/3.9/bin

# Secret configs
if [[ -s "${HOME}/.dotfiles/secret.zsh" ]]; then
  source "${HOME}/.dotfiles/secret.zsh"
fi

export TERM=xterm-256color
