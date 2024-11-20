
## Tricks

- replace ^M /  : `<shift><ctrl>vm` (keep `<shift><ctrl>` pressed)

### autocommands / autocmd

see: https://vi.stackexchange.com/a/43781

In Lua:
```lua
vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
    pattern = { "*" },
    callback = function()
        if vim.opt.buftype:get() == "terminal" then
            vim.cmd(":startinsert")
        end
    end
})

```
Or in Vimscript:
```vim
:au TermOpen,BufEnter * if &buftype == 'terminal' | :startinsert | endif
```

If you use toggleterm, it may conflict with option  persist_mode = true as it will revert to normal mode upon entering terminal.

Anyway you don't need this autocommand if you use toggleterm with options: start_in_insert = true, persist_mode = false.

## get file name and file path

in `vim`:

```vim
  let g:local_source_dir = vim.fn.fnamemodify(expand('<sfile>'), ':h').'/local/'
  if filereadable(g:local_source_dir . 'init.vim')
    execute 'lua require("user.local.settings)' 
    " . g:local_source_dir . 'init.vim'
  endif
```

in `lua`

```lua
  -- path:
  vim.fn.fnamemodify(expand('<sfile>'), ':h').'/local/'
  
  -- full file name:
  vim.fn.expand('%')
  
```

## vim modes

```lua
  local mode = vim.api.nvim_get_mode().mode
```

## spell

Enhance runtime path with folder containing the spell files (e.g. ~/.config/nvim/lua/user/)

- https://www.vimfromscratch.com/articles/spell-and-grammar-vim
- https://ostechnix.com/use-spell-check-feature-vim-text-editor/
- http://ftp.vim.org/vim/runtime/spell/

