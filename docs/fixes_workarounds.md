# Fixes and Workarounds


## Guide to install neovim on Windows

[The Comprehensive Guide to Using Neovim with LSP and Treesitter on Windows Without Admin Rights](https://devctrl.blog/posts/neovim-on-windows/#treesitter-configuration)

## Tree-sitter install errors on Windows

install llvm, zig or mingw (gcc) by choco

```sh
  choco install mingw -fy  # (gcc / mingw, llvm, zig are required for treesitter)
  # choco install llvm -fy
  # choco install zig -fy
```

## npm certifcicate error (Windows)

```sh
npm config set strict-ssl false [ --unsafe-perm true ]  
# (or:  yarn config set strict-ssl false)
```

1. Set environment variable NODE_TLS_REJECT_UNAUTHORIZED:

for bash or ZSH:

```sh
export NODE_TLS_REJECT_UNAUTHORIZED=0
```


for CMD Windows:

```sh
set NODE_TLS_REJECT_UNAUTHORIZED=0
```

for PowerShell Windows:

```sh
$env:NODE_TLS_REJECT_UNAUTHORIZED="0"
```

2. Install tree-sitter-cli
 
```sh
npm install tree-sitter-cli -f -y
```

3. Source:

- https://stackoverflow.com/questions/36494336/npm-install-error-unable-to-get-local-issuer-certificate
- https://bobbyhadz.com/blog/npm-err-unable-to-get-local-issuer-certificate


## ipython send to terminal wrong indent

- https://github.com/akinsho/toggleterm.nvim/issues/243
- https://github.com/akinsho/toggleterm.nvim/issues/425


## Tree-sitter install errors on Windows

install llvm, zig or mingw (gcc) by choco

```sh
  choco install mingw -fy  # (gcc / mingw, llvm, zig are required for treesitter)
  # choco install llvm -fy
  # choco install zig -fy
```

see also [The Comprehensive Guide to Using Neovim with LSP and Treesitter on Windows Without Admin Rights](https://devctrl.blog/posts/neovim-on-windows/#treesitter-configuration)

### More to avoid Treesitter errors

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

## ekickx/clipboard-image.nvim, 2023-05-31

!SEE: kraxli/clipboard-image.nvim

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

## R.nvim


### Set up and initialization

Create user profile file:

```sh
touch ~/.Rprofile
mkdir -p ~/.R/libs
```

In### Set up and initialization

Create user profile file:

```sh
touch ~/.Rprofile
mkdir -p ~/.R/libs
```

In `~/.Rprofile`


```r
R_LIBS_USER='~/.R/libs/'
.libPaths(R_LIBS_USER, include.site = TRUE)
cat("\nUser profile file, ~/.Rprofile, has been loaded\n")
```

see [stackoverflow](https://stackoverflow.com/a/31707983) 

See `help(Startup)` and `help(.libPaths)` as you have several possibilities where this may have gotten set. Among them are

    setting R_LIBS_USER
    assigning .libPaths() in .Rprofile or Rprofile.site

and more.  `~/.Rprofile`


```r
R_LIBS_USER='~/.R/libs/'
.libPaths(R_LIBS_USER, include.site = TRUE)
cat("\nUser profile file, ~/.Rprofile, has been loaded\n")
```

see [stackoverflow](https://stackoverflow.com/a/31707983) 

See `help(Startup)` and `help(.libPaths)` as you have several possibilities where this may have gotten set. Among them are

    setting R_LIBS_USER
    assigning .libPaths() in .Rprofile or Rprofile.site

and more. 

### Installing the r_language_server

if `vim` command: `LspInstall r_language_server` fails, try in `R`:

```sh
sudo apt install build-essential libcurl4-gnutls-dev libxml2-dev libssl-dev
```

```R
install.packages(c("languageserver", "devtools"))
# or install the developement version
# remotes::install_github("REditorSupport/languageserver")
```

### Unix only

```sh
cd ~/.R/
git clone https://github.com/jalvesaq/colorout.git
R CMD INSTALL colorout
```
## Glyphs / Icons

- For file type icons, copy Glyphs from Oil! :-)
- Awesome fonts: https://docs.fontawesome.com/desktop/add-icons/glyphs


## Debugger

https://www.reddit.com/r/AstroNvim/comments/1f3e7lj/how_to_setup_astorvim_for_net_development/
