local M = {}

function M.create_toggle_term(args, count)
  -- local fn = vim.fn
  local term = require("toggleterm.terminal").get(count)
  local direction = "vertical"
  local size = string.format(80)
  if args.direction then direction = args.direction end
  -- if dir and fn.isdirectory(fn.expand(dir)) == 0 then dir = nil end
  if args.size then size = string.format(args.size) end

  if term then
    require("toggleterm").toggle_command("size=" .. size .. " direction=" .. direction, count)
  else
    local cmd = ""
    if args.cmd then cmd = args.cmd end
    local vim_eval_str = string.format(count)
      .. 'TermExec cmd="'
      .. cmd
      .. '" size='
      .. size
      .. ' direction="'
      .. direction
      .. '"'
    vim.cmd(vim_eval_str)
    -- maps.n["<leader>tP"] = { '<cmd>99TermExec cmd="ipython3" size=80 direction=vertical<cr>', desc = "Ipython term vertical split" }
    -- maps.n["<leader>tP"] = { function() require('toggleterm.terminal').Terminal:new({cmd=python,  direction="vertical", count=99}):toggle() end, desc = "Ipython term vertical split" }
    -- return require('toggleterm.terminal').Terminal:new({ id = count, dir = dir, direction = direction }), true
  end
end

-- maps.n["<leader>tp"] = { function() require('user.toggleterm').create_toggle_term({cmd=python, direction='vertical'}, py_term_num) end }
-- maps.n["<leader>tP"] = { function() require('user.toggleterm').create_toggle_term({cmd=python, direction='float'}, py_term_num) end }

return {
  "akinsho/toggleterm.nvim",
  opts = function(_, opts)
    opts.size = 80
    -- opts.mappings.n["q"] = { "<Esc><Cmd>ToggleTerm<CR>", desc = "Toggle terminl" }
    -- opts.mappings.n["<c-q>"] = { "<Cmd>close!<CR>", desc = "Toggle terminl" }
  end,
}
