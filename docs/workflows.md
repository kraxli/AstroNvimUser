# General

show documentation of function below cursor: `<leader>lK` or `<leader>K`

# Python

```vim
:PyrightOrganizeImports " to organzie imports of python files
```

# Lua

```vim
  :luafile <lua_file_to_run>
```

in the file return a function by

```lua
return my_function
-- or
M.myFucntion = my_function()
return M
```

to run the function to debug

# Neovim

## Debugging

Get lsp-config: `lua print(vim.lsp.get_log_path())`
