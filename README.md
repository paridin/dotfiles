To install add to `.zshrc` file

Currently I'm using with [zimfw](https://github.com/zimfw/zimfw)

## Instalation
```zsh
git clone https://github.com/paridin/dotfiles.git ~/.dotfiles
```

## load personal dotfiles

Edit your `.zshrc` (`vim ~/.zshrc`) then add at the end the next if condition.

```zsh
if [[ -s "${HOME}/.dotfiles/init.zsh" ]]; then
   source "${HOME}/.dotfiles/init.zsh"
fi
```
