source ${HOME}/.dotfiles/paridin-prompt/paridin-prompt.zsh-theme

export PATH=$HOME/.local/bin:$PATH

# Secret configs
if [[ -s "${HOME}/.dotfiles/secret.zsh" ]]; then
  source "${HOME}/.dotfiles/secret.zsh"
fi
