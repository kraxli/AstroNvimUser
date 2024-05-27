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

## dos / unix (^M)

- vim: `set fileformat=dos/unix`
- commandline: `dos2unix filename`
- keys: `Ctrl+Q Ctrl+M` (or `Ctrl+V Ctrl+M`)

## Codeium

codeium server crashed. Try to add

```zsh
  export no_proxy=127.0.0.1
```

to your `.bashrc` / `.zshrc` file.

And run only one nvim instance (with codeium active) 

## Peek.nvim (preview)

Solution:

1. set <export> `DENO_TLS_CA_STORE=system` in "Environment Variables for your account" (MS Windows) or in `.zshrc / .bashrc` (Linux)
2. remove old installation
3. start nvim with Lazy to reinstall

Additionally it may help to:

```sh
  cd C:\SRDEV\XDG_HOME\data\nvim-data\lazy\peek.nvim
  deno task build:fast --allow-net --unsafely-ignore-certificate-errors --quiet
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

### Tree-sitter on Windows

#### Downloading problems / curl

set-up `.curlrc` e.g. in `$XDG_CONFIG_HOME\.curlrc`

File content of example `.curlrc`: https://gist.github.com/v1m/f1d4751883f19c916515

```sh
# .curlrc :
--ssl-revoke-best-effort
-k
--insecure

# additionally, in case PROXY settings are not set generally for my account, I can set it in .curlrc
```

in neovim run: `:checkhealth nvim-treesitte` and try `TSInstall markdown` or disable it e.g. by `TSBufDisable markdown`.
