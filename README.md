# Dotfiles

## Dependencies

Neovim

Packer
```
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

## Apply
```
sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply miqrc
```

Open nvim and run `:PackerSync`


