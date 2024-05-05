# Vim tips and tricks

## Get list of lazy.nvim plugins

run in nvim with `lua ...`

```lua
plugins_tbl = require('lazy').plugins(); file = io.open("plugins.txt", "a"); io.output(file) for k, v in pairs(plugins_tbl) do io.write(v[1], '\n') end; io.close(file)
```

## Debugging Vim

- https://codeinthehole.com/tips/debugging-vim-by-example/
- https://inlehmansterms.net/2014/10/31/debugging-vim/

### General Debugging with Verbose

```vim
" set verbose command
set verbosefile=verbose.log
set verbose=13

" set verbose on startup
vim -V9 file.text
```

To investigate, I looked up which Vim file had last set the option by prepending `:verbose`:

```vim
:verbose set textwidth?
```

## General tips and tricks

File is blocked for saving? Try:

```viml
  set buftype=
```

- am I now a bit faster? Yes

- [ ] adsf

# Alternatives / HowTo

open external applcation:

```lua
  commandsOpen = {unix="xdg-open", mac="open", win='Invoke-Expression'}

  if vim.fn.has "mac" == 1 then
    osKey = "mac"
  elseif vim.fn.has "unix" == 1 then
    osKey = "unix"
  elseif (vim.fn.has('win64') | vim.fn.has('win32') then
    osKey='win'
  end
  local openDir = [[<cmd>lua os.execute(commandsOpen[osKey] .. ' ' .. vim.fn.shellescape(vim.fn.fnamemodify(vim.fn.expand('<sfile>'), ':p'))); vim.cmd "redraw!"<cr>]]
  keymap("n", "<F6>", openDir, {})

  x = {
        ":execute 'silent! !xdg-open ' . shellescape(expand('<cfile>'), 1)<CR>",
        "Open the file under cursor with system app",
      },

```
