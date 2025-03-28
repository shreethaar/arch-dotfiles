# arch-dotfiles 

**IN PROGRESS**

> Arch Dotfiles 
> [!CAUTION]
> Be careful when running any unaudited scripts. These are my personal dotfiles and there might be some configurations which you may not need or like. I suggest to pick and choose only the packages you would want to install. Also, they are generally intended to work with the latest Arch. 

## Overview

### Desktop Environment

**i3** is the desktop environment of choice. 

### Browser


### Terminal Emulator


### Shell


### Text Editors

**Neovim**
Language servers:
- Rust: `rust-analyzer`
- C#: `OmniSharp`
- Go: `gopls`
- C/C++: `clangd`

##### Key Bindings for Neovim:
| Key | Action |
|-----|--------|
|\<leader\>rn	|Rename symbol|
|gd	|Go to definition|
|K	|Hover documentation|
|\<leader\>ca|Code actions|
|\<leader\>ff|Find files (Telescope)|
|\<leader\>fg |Live grep (Telescope)|
|\<leader\>fb	|Buffer list (Telescope)|
|\<C-space\>  |Rust hover actions
|\<leader\>gi	|Go implementations|
