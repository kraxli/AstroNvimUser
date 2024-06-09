local M = {}

function M.quick_notification(msg, type) astronvim.notify(msg, type or "info", { timeout = 0 }) end

function M.vim_opt_toggle(opt, on, off, name)
  if on == nil then on = true end
  if off == nil then off = false end
  if not name then name = opt end
  local is_off = vim.opt[opt]:get() == off
  vim.opt[opt] = is_off and on or off
  M.quick_notification(name .. " " .. (is_off and "Enabled" or "Disabled"))
end

function M.async_run(cmd, on_finish)
  local lines = { "" }

  local function on_event(_, data, event)
    if (event == "stdout" or event == "stderr") and data then vim.list_extend(lines, data) end

    if event == "exit" then
      vim.fn.setqflist({}, " ", {
        title = table.concat(cmd, " "),
        lines = lines,
        efm = "%f:%l:%c: %t%n %m",
      })
      if on_finish then on_finish() end
    end
  end

  vim.fn.jobstart(cmd, {
    on_stdout = on_event,
    on_stderr = on_event,
    on_exit = on_event,
    stdout_buffered = true,
    stderr_buffered = true,
  })
end

function M.toggle_qf()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_exists = true
      break
    end
  end
  if qf_exists then
    vim.cmd.cclose()
  elseif not vim.tbl_isempty(vim.fn.getqflist()) then
    vim.cmd.copen()
  end
end

local function getOs()
  local osKey = ""

  if vim.fn.has "mac" == 1 then
    osKey = "mac"
  elseif vim.fn.has "unix" == 1 then
    osKey = "unix"
  elseif vim.fn.has "win64" or vim.fn.has "win32" then
    osKey = "win"
  end

  return osKey
end

function M.get_visual_selection()
  -- local mode = vim.api.nvim_get_mode()["mode"]  -- or vim.fn.mode()
  -- if mode ~= 'v' or mode ~= 'x' then
  --   return ''
  -- end

  vim.cmd 'noau normal! "vy"'
  selection = string.gsub(vim.fn.getreg "v", "^%s*(.-)%s*$", "%1") -- remove leading and trailing spaces

  return selection
end

-- see e.g. https://github.com/theHamsta/nvim-treesitter/blob/a5f2970d7af947c066fb65aef2220335008242b7/lua/nvim-treesitter/incremental_selection.lua#L22-L30
function M.get_visual_range()
  vim.cmd [[normal :esc<CR> gv]] -- this is required since the following two getpos() calls get the last but not the current visual selection
  local _, line_start, col_start, _ = unpack(vim.fn.getpos "'<")
  local _, line_end, col_end, _ = unpack(vim.fn.getpos "'>")
  -- local line_start = vim.fn.getpos("'<")[2]
  -- local col_start = vim.fn.getpos("'<")[3]
  local selection = vim.fn.getline(line_start, line_end)
  -- print(vim.inspect(nvim_buf_get_text(0, line_start, col_start, line_end, col_end, {}))) ??

  if #selection == 0 then -- or vim.fn.len(selection) == 0
    return ""
  end

  local first_line = selection[1]
  local last_line = selection[#selection]
  first_line = string.sub(first_line, col_start, first_line:len())
  first_line = string.gsub(first_line, "^%s*(.-)%s*$", "%1") -- remove all spaces (not only leading and trailing)  last_line =  string.sub(last_line, 1, col_end)
  last_line = string.gsub(last_line, "^%s*(.-)%s*$", "%1") -- remove all spaces (not only leading and trailing)
  selection[1] = first_line
  selection[#selection] = last_line

  return table.concat(selection, "\n")
end

function M.get_visual_lines()
  vim.cmd [[normal :esc<CR> gv]] -- this is required since the following two getpos() calls get the last but not the current visual selection
  local _, line_start, col_start, _ = unpack(vim.fn.getpos "'<")
  local _, line_end, col_end, _ = unpack(vim.fn.getpos "'>")
  -- vim.cmd [[normal :esc<CR>]]
  local selection = vim.fn.getline(line_start, line_end) -- or nvim_buf_get_lines()

  if #selection == 0 then -- or vim.fn.len(selection) == 0
    return ""
  end

  return table.concat(selection, "\n")
end

function M.rm_trailing_spaces(str)
  local str = string.gsub(str, "[ \t]+%f[\r\n%z]", "")
  return str
end

function M.execute(str)
  local commandsOpen = { unix = "xdg-open", mac = "open", powershell = "Start-Process", win = "explorer" } -- win='start /b ""'
  local os = getOs()
  sys_app = commandsOpen[os] -- must be global to be used in vimscript below

  if os == "win" then
    vim.cmd [[ execute 'silent! !' . luaeval('sys_app') . ' ' .shellescape(luaeval('str'), 1) ]]
  else
    vim.fn.jobstart({ sys_app, str }, { detach = true })
  end
end

function M.google()
  local keyword = vim.fn.expand "<cword>"
  local url = "http://www.google.com/search?q=" .. keyword
  M.execute(url)
end

-- @param mode: the active mode ('n', 'i', 'v', 'x')
function M.sys_app_open(mode)
  local mode = mode or vim.api.nvim_get_mode()["mode"]
  local commandsOpen = { unix = "xdg-open", mac = "open", powershell = "Start-Process", win = "explorer" } -- win='start /b ""'
  local os = getOs()

  -- powershell:
  --   set shell=powershell shellquote=( shellpipe=\| shellredir=> shellxquote=
  --   set shellcmdflag=-NoLogo\ -NoProfile\ -ExecutionPolicy\ RemoteSigned\ -Command

  if os == "win" and vim.o.shell == "powershell" then os = "powershell" end

  sys_app = commandsOpen[os] -- must be global to be used in vimscript below

  if mode == "v" or mode == "x" then
    path = M.get_visual_selection() -- global such that it can be used in vim.cmd()
  else
    path = vim.fn.expand "<cfile>"
    -- path = path or vim.fn.expand("<cfile>")  -- in case of input variable path, <cfile>  or <cword>
    path = vim.fn.fnamemodify(path, ":p")
  end

  local is_not_web_address = vim.fn.empty(string.match(path, "[a-z]*://[^ >,;()]*")) == 1
  local is_empty_path = vim.fn.empty(vim.fn.glob(path)) == 1

  if is_empty_path and is_not_web_address then path = vim.fn.expand "%:p:h" end

  if os == "win" then
    vim.cmd [[ execute 'silent! !' . luaeval('sys_app') . ' ' .shellescape(luaeval('path'), 1) ]]
  else
    vim.fn.jobstart({ sys_app, path }, { detach = true })
  end

  -- os.execute(commandsOpen[osKey] .. ' ' .. vim.fn.shellescape(vim.fn.fnamemodify(vim.fn.expand('<sfile>'), ':p'))) -- ; vim.cmd "redraw!"
end

function M.openExplorer()
  local commandsOpen = { unix = "xdg-open", mac = "open", powershell = "Start-Process", win = 'start /b ""' }

  os.execute(commandsOpen[osKey] .. " " .. vim.fn.shellescape(vim.fn.fnamemodify(vim.fn.expand "<sfile>", ":p")))
  vim.cmd "redraw!"
end

function M.cacheClean()
  local opts_unix = "-rf"
  local opts_win = ""

  if vim.has "win" or vim.has "win64" then
    opts = opts_win
  else
    opts = opts_unix
  end

  os.execute "rm  $XDG_DATA_HOME/nvim/packer_compiled.lua"

  os.execute("rm " .. opts .. " $XDG_CACHE_HOME/.cache/nvim/*")
  os.execute("rm " .. opts .. " $XDG_DATA_HOME/nvim/*")
  os.execute("rm " .. opts .. " $XDG_CONFIG_HOME/nvim-data/*")
  os.execute("rm " .. opts .. " $XDG_DATA_HOME/nvim-data/*")

  -- XDG_DATA_HOME="${XDG_DATA_HOME:-"$HOME/.local/share"}"
  -- XDG_CACHE_HOME="${XDG_CACHE_HOME:-"$HOME/.cache"}"
  -- XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"$HOME/.config"}"
  -- XDG_DATA_DIRS
end

function M.better_search(key)
  return function()
    local searched, error =
      pcall(vim.cmd.normal, { args = { (vim.v.count > 0 and vim.v.count or "") .. key }, bang = true })

    -- if searched then
    --   pcall(vim.cmd.normal, "zzzv")
    -- else
    --   M.quick_notification(error, "error")
    -- end
    -- vim.opt.hlsearch = searched

    if not searched and type(error) == "string" then require("astronvim.utils").notify(error, vim.log.levels.ERROR) end
  end
end

function M.insert_list_bullet(bullet_type)
  bullet = bullet_type or "-"
  local _, cursor_line, cursor_col, _, _ = unpack(vim.fn.getcurpos())
  -- vim.cmd([[normal ^i- <esc>]])
  vim.cmd [[ execute "normal ^i" . luaeval('bullet') . ' ' ]]
  vim.fn.setpos(".", { 0, cursor_line, cursor_col + 2, 0 }) -- 15G25|
end

function M.reset_cursor_pos(callback, offset, ...)
  offset = offset or 2
  -- e.g. lua require("user.utils").reset_cursor_pos(function() print('x') end)
  local _, cursor_line, cursor_col, _, _ = unpack(vim.fn.getcurpos())
  callback()
  vim.fn.setpos(".", { 0, cursor_line, cursor_col + offset, 0 }) -- 15G25|
end

-- --- Install all Mason packages from mason-lspconfig, mason-null-ls, mason-nvim-dap
-- function M.mason.install_all()
--   local registry_avail, registry = pcall(require, "mason-registry")
--   if not registry_avail then
--     vim.api.nvim_err_writeln "Unable to access mason registry"
--     return
--   end
--
--   local installed = false
--   for plugin_name, opts in pairs {
--     ["mason-lspconfig"] = { type = "server", map = "lspconfig" },
--     ["mason-null-ls"] = { type = "source", map = "null_ls" },
--     ["mason-nvim-dap"] = { type = "source", map = "nvim_dap" },
--   } do
--     local plugin_avail, plugin = pcall(require, plugin_name .. ".settings")
--     if plugin_avail then
--       local mappings = require(plugin_name .. ".mappings." .. opts.type)[opts.map .. "_to_package"]
--       local pkgs = plugin.current.ensure_installed
--       for _, pkg in ipairs(pkgs) do
--         local mason_pkg = mappings[pkg]
--         if not registry.is_installed(mason_pkg) then
--           installed = true
--           astronvim.mason.update(mason_pkg)
--         end
--       end
--     end
--   end
--   if not installed then astronvim.notify "Mason: No packages to install" end
-- end

function M.handle_checkbox_autolist()
  local config = require "autolist.config"
  local auto = require "autolist.auto"

  local checkbox_pattern = " [ ]"
  -- local checkbox_pattern_done = " [x]"

  local filetype_list = config.lists[vim.bo.filetype]
  local line = vim.fn.getline "."

  for i, list_pattern in ipairs(filetype_list) do
    local list_item = line:match("^%s*" .. list_pattern .. "%s*") -- only bullet, no checkbox
    if list_item == nil then goto continue_for_loop end
    list_item = list_item:gsub("%s+", "")
    local is_list_item = list_item ~= nil -- only bullet, no checkbox
    local is_checkbox_item = line:match("^%s*" .. list_pattern .. "%s*" .. "%[.%]" .. "%s*") ~= nil -- bullet and checkbox

    if is_list_item == true and is_checkbox_item == false then
      list_item = list_item:gsub("%)", "%%)")
      vim.fn.setline(".", (line:gsub(list_item, list_item .. checkbox_pattern, 1)))

      local cursor_pos = vim.api.nvim_win_get_cursor(0)
      if cursor_pos[2] > 0 then
        vim.api.nvim_win_set_cursor(0, { cursor_pos[1], cursor_pos[2] + checkbox_pattern:len() })
      end
      goto continue
    else
      auto.toggle_checkbox()
      goto continue
    end
    ::continue_for_loop::
  end
  ::continue::
end

function M.handle_checkbox_bullets()
  -- TODO: support more list item types like alpha-numerics

  local checkbox_pattern = " [ ]"
  -- local checkbox_pattern_done = " [x]"

  local check_mark_string = vim.g.bullets_checkbox_markers
  local list_items = { "-", "*" }
  -- local filetype_list = {}
  -- check_mark_string:gsub(".",function(c) table.insert(filetype_list, c) end)
  local line = vim.fn.getline "."

  for i, list_pattern in ipairs(list_items) do
    local list_item = line:match("^%s*" .. list_pattern .. "%s*") -- only bullet, no checkbox
    if list_item == nil then goto continue_for_loop end
    list_item = list_item:gsub("%s+", "")
    local is_list_item = list_item ~= nil -- only bullet, no checkbox
    local is_checkbox_item = line:match("^%s*" .. list_pattern .. "%s*" .. "%[.%]" .. "%s*") ~= nil -- bullet and checkbox

    if is_list_item == true and is_checkbox_item == false then
      list_item = list_item:gsub("%)", "%%)")
      vim.fn.setline(".", (line:gsub(list_item, list_item .. checkbox_pattern, 1)))

      local cursor_pos = vim.api.nvim_win_get_cursor(0)
      if cursor_pos[2] > 0 then
        vim.api.nvim_win_set_cursor(0, { cursor_pos[1], cursor_pos[2] + checkbox_pattern:len() })
      end
      goto continue
    else
      vim.cmd "ToggleCheckbox"
      goto continue
    end
    ::continue_for_loop::
  end
  ::continue::
end

-- function M.NumberedList()
--   vim.cmd [[
--   function! NumberedList(...) range
--     " or simply use !cat -n on selected range
--     if a:0 != 0 | let style=a:1 | else | let style='.' | endif
--     let line_start = getpos("'<")[1]
--     let line_end = getpos("'>")[1]
--
--     for num in range(line_start, line_end)
--       let current_line = getline(num)
--       let listNum = num - line_start + 1
--
--       " TODO allow for other list types as (capital) roman numbers, (capital) letters
--       call setline(num, substitute(current_line, '^\(\s*\)', '\1' . listNum . style . ' ', ''))
--     endfor
--   endfunction
--   ]]
-- end

return M
