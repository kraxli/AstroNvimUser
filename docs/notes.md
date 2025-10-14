# Configurations

```sh
ipython -i --no-autoindent --no-autoedit-syntax --nosep
# -i or --pylab or --matplotlib
```

# Where to find what

packer plugins directory: /home/dave/.local/share/nvim/lazy
nvim cache: /home/dave/.local/share/nvim/packer_compiled.lua

```bash
  # Set branch to master unless specified by the user
  declare LV_BRANCH="${LV_BRANCH:-"master"}"
  declare -r LV_REMOTE="${LV_REMOTE:-lunarvim/lunarvim.git}"
  declare -r INSTALL_PREFIX="${INSTALL_PREFIX:-"$HOME/.local"}"

  declare -r XDG_DATA_HOME="${XDG_DATA_HOME:-"$HOME/.local/share"}"
  declare -r XDG_CACHE_HOME="${XDG_CACHE_HOME:-"$HOME/.cache"}"
  declare -r XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"$HOME/.config"}"

  declare -r LUNARVIM_RUNTIME_DIR="${LUNARVIM_RUNTIME_DIR:-"$XDG_DATA_HOME/lunarvim"}"
  declare -r LUNARVIM_CONFIG_DIR="${LUNARVIM_CONFIG_DIR:-"$XDG_CONFIG_HOME/lvim"}"
  declare -r LUNARVIM_BASE_DIR="${LUNARVIM_BASE_DIR:-"$LUNARVIM_RUNTIME_DIR/lvim"}"

```

utils.set_mappings(astronvim.user_opts("mappings", maps))

dap under windows: https://github.com/AstroNvim/AstroNvim/issues/1605

# Fixes

Error "heirline setup() takes only one argument"

```bash
  cd $XDG_DATA_HOME/nvim/site/pack/packer/opt/heirline.nvim/
  git co f684e4c
```

# Astronvim

If you are using e.g. Micahl's config, you will notice that I have the file user/lsp/formatting.lua. You will need to put these settings in that file. As described in the documentation regarding splitting up the config, separate files take precedence over user/init.lua. so that file will not be used to load that option since other formatting options are defined in a separate file.

see:https://github.com/AstroNvim/AstroNvim/issues/1259

# Nice colorschemes supporting light and dark background

| Theme                                             | Time of the day |
| ------------------------------------------------- | :-------------: |
| [rose-pine](https://github.com/rose-pine/neovim)  |   [1am, 9am)    |
| [tokyonight](https://github.com/folke/tokyonight) |   [9am, 5pm)    |

- one-nvim

# lvim-config

Kraxli's LunarVim Config

# Examples

See [LunarVim FAQ](https://www.lunarvim.org/community/faq.html#what-is-null-ls-and-why-do-you-use-it)

Where can I find some example configs?

If you want ideas for configuring LunarVim you can look at these repositories.

- Chris - https://github.com/ChristianChiarulli/lvim
- Abouzar - https://github.com/abzcoding/lvim
- https://github.com/vuki656/nvim-config

# Plugins

- `rcarriga/nvim-notify`: A fancy, configurable, notification manager for NeoVim (messages, error, popup)

## Packer

Errors after `lvim +q`: In case of compile (e.g. lsp-compile) errors or issues with (lazy) loading plugins, delete `~/.config/lvim/plugin` folder and run `PackerCompile`.

# Spell files

http://ftp.vim.org/vim/runtime/spell/de/

# Vim / Neovim

You can use the following name to view Buftype settings, when Buftype=nofile, cannot save the file, only when buftype= empty, can save

# Appearance

- change to the "telescope floating dialog window" --> this is controlled by the colorscheme!!

# Miscellaneous is ssues solved

- fzf not installed issue solved by:

  - ~/.local/share/nvim/site/pack/packer/opt/telescope-fzf-native.nvim and run make
  - see:https://github.com/nvim-telescope/telescope-fzf-native.nvim/issues/47

# Nerdfonts

[find a symbol](https://www.nerdfonts.com/cheat-sheet)

# Treesitter

Treesitter install directories:

- lazy.nvim: ~/.local/share/nvim/lazy/nvim-treesitter/parser
- packer.nvim: ~/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/parser

