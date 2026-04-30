# AstroNvim User Configuration

My personal AstroNvim user configuration for [AstroNvim v5](https://github.com/AstroNvim/AstroNvim)

This AstroNvimUser configuration builds on the user configuraion of [Micah Halter](https://code.mehalter.com/AstroNvim_user/~files/master)

## Installation

```zsh
git clone https://github.com/kraxli/AstroNvimUser.git ~/.config/nvim
```

Initialize AstroVim

```zsh
nvim  --headless -c 'quitall'
```

## Adding user settings

```zsh
git clone https://github.com/<git_user>/<your_local_nvim_repo.git>  ~/.config/nvim/lua/user
```

## Notes on this repo

The suffix `X` describes plugin-configs files which are _extensions_ of plugin-configs by Micah. The suffix `L` describes that it is a _legacy_ plugin file by Micah but still used by myself.
I separate own files and configurations as good as possible, to ease updating and merging.
