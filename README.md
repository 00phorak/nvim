# About

This repo serves as a quick access to my nvim configuration with my custom keybinds.

# How to
First backup existing nvim configuration. Clear cache etc. to have a clean installation. (Usually just renaming nvim directory is sufficient unless you have a lot of stuff installed)

- Clone repository
- Install packer
```bash
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```
 If there's a problem with packer, delete compiled packer and run PackerCompile
- Open nvim and run PackerSync

Enjoy
