# Fixes and Workarounds

## ipython send to terminal wrong indent

- https://github.com/akinsho/toggleterm.nvim/issues/243
- https://github.com/akinsho/toggleterm.nvim/issues/425

## ekickx/clipboard-image.nvim, 2023-05-31

Health issue: https://github.com/ekickx/clipboard-image.nvim/issues/50

```zsh
# modify the health.lua in clipboard-image plugin

local health = vim.health or require "health"

# instead of

local health = require "health"

# and it worked for me
```

## iamcco/markdown-preview.nvim, 2023-05-31

tslib not found:

```zsh
# with npm:
cd $XDG_DATA_HOME/nvim/lazy/markdown-preview.nvim/app && npm install && npm audit fix --force

# or with yarn:
cd $XDG_DATA_HOME/nvim/lazy/markdown-preview.nvim/app && yarn install
```

## ipython / jupyter does not pick up venv (is not available in venv)

```zsh
sudo apt-get install libsqlite3-dev
pyenv uninstall 3.x.yy && pyenv install 3.x.yy
```

## Treesitter

Disable `treesitter` by e.g. `TSBufDisable markdown`. To see a list of modules, see `TSModuleInfo`.
