local opts = { noremap = true, silent = true }

-- open system app for file under cursor or file explorer
vim.api.nvim_set_keymap("", "<F3>", [[<cmd>lua require('utils').sys_app_open()<CR>]], opts)

-- writer
-- vim.api.nvim_set_keymap("n", "<c-s-v>", "<cmd>PasteImg<cr>", { noremap = false })

vim.cmd [[
  nmap zb viwsa*.
  nmap sb viwsa*.
  nmap zi viwsa_

  imap jj <ESC>
  imap jk <ESC>

  vmap <c-c> y
  xmap <c-c> y

  vmap zb sa*.
  vmap sb sa*.
  vmap zi sa_

  " map <leader>q <Nop>
  " unmap <leader>q
]]

-- vim.keymap.set("n", "zb", "viwsa*.", {noremap=false, desc = "Bold word"})

-- vim.keymap.del()
vim.keymap.set("n", "X", "<nop>", {})

-- -------------------------------------------------------
-- Commands
-- -------------------------------------------------------

local create_command = vim.api.nvim_create_user_command
create_command("Ids", "execute('e " .. dirGdrive .. fileIds .. "')", { desc = "Id file" })


vim.cmd([[

  " ┌────────────────┐
  " │ local settings │
  " └────────────────┘

  if has('unix')
    let g:python_host_prog = '/usr/bin/python'
    let g:python3_host_prog = '/usr/bin/python3'
    " let g:python3_host_prog = '/~/.pyenv/versions/python364/bin/python'

    "" To disable Python 2 support:
    " let g:loaded_python_provider = 1
  else
    let g:python3_host_prog = 'C:/ProgramData/Anaconda3-5.2.0/python.exe'
  endif

  " Commpands
  command! HelpVim :execute('e ' . g:dirOnedrive . 'VimWiki/VimCommands_learning_Vi_Vim.wiki')
  command! InstallLinux :execute('e ' . g:dirDbox . 'LinuxInstall/A_linux_mint_install_2025_woNvim.sh') 
  command! InstallNvim :execute('e ' . g:dirDbox . 'LinuxInstall/nvim_install.sh') 

  command! Bash :execute('e ' . g:dirOnedrive . 'SoftwareTools/Linux/Shell/bash_summary.sh')
  command! TBash :execute('e ' . g:dirOnedrive . 'SoftwareTools/Linux/Shell/bash_summary.sh')
  command! Plugins :e /home/dave/.config/nvim/config/plugins.yaml

  command! Cd2Pkd :execute('cd ' . g:dirPkd)
  command! Cd2Nvim :cd g:dirNvim
  command! Cd2D :execute('cd ' . g:dirOnedrive . '03_Coding/D')
  command! Cd2Python :execute('cd ' . g:dirOnedrive . '03_Coding/Python')

]])


-- -------------------------------------------------------
-- Functions:
-- -------------------------------------------------------

vim.cmd([[

function! Header_promote(...)
    if a:0 == 0 | let lineNum = line('.') | else | let lineNum = a:1 | endif

    let header_depth_max = 6

    let current_line = getline(lineNum)
    let num_hashs = len(substitute(current_line, '^\(\s*#*\).*$', '\1', ''))
    let hashs2add = repeat('#', min([v:count1 + num_hashs, header_depth_max]))

    if match(current_line, '^\s*#\{1,' .. header_depth_max .. '}\s') >= 0
      " let subsi_str = '^\(\s*\)#\{1,' .. (header_depth_max-1) .. '} \(.*$\)'
      let subsi_str = '^\(\s*\)#\{1,' .. (header_depth_max-1) .. '} \(.*$\)'
      call setline(lineNum, substitute(current_line, subsi_str, '\1' .. hashs2add .. ' \2', ''))
      return
    endif
    if match(current_line, '^\s*[^#]') >= 0
      call setline(lineNum, substitute(current_line, '^\(\s*\)\(.*$\)', '\1' .. hashs2add .. ' \2', ''))
      return
    endif

  endfunction

  function! Header_demote(...)
    if a:0 == 0 | let lineNum = line('.') | else | let lineNum = a:1 | endif

    let header_depth_max = 6

    let current_line = getline(lineNum)
    let hashs2subtract = v:count > 0 ? v:count : 1 
    let num_hashs = len(substitute(current_line, '^\(\s*#*\).*$', '\1', ''))
  
    let num_hashs_new = num_hashs >= hashs2subtract ? num_hashs - hashs2subtract : header_depth_max 

    if match(current_line, '^\s*#\{2,' .. header_depth_max .. '}\s') >= 0
      " call setline(lineNum, substitute(current_line, '^\(\s*#\{1,' .. header_depth_max .. '}\)' .. repeat('#', num_hashs_new) .. ' \(.*$\)', '\1 \2', ''))
      let subsi_str = '^\(\s*#\{1,' .. header_depth_max .. '}\) \(.*$\)'
      call setline(lineNum, substitute(current_line, subsi_str, repeat('#', num_hashs_new) .. ' \2', ''))
      return
    endif
    if match(current_line, '^\s*#\{1}\s') >= 0
      call setline(lineNum, substitute(current_line, '^\(\s*\)# \(.*$\)', '\1\2', ''))
      return
    endif

  endfunction

    " see: https://github.com/kraxli/vim-mkd-org/blob/master/autoload/mkdd.vim
    function! NumberedList(...) range
      " or simply use !cat -n on selected range
      if a:0 != 0 | let style=a:1 | else | let style='.' | endif
      let line_start = getpos("'<")[1]
      let line_end = getpos("'>")[1]

      for num in range(line_start, line_end)
        let current_line = getline(num)
        let listNum = num - line_start + 1

        " TODO allow for other list types as (capital) roman numbers, (capital) letters
        call setline(num, substitute(current_line, '^\(\s*\)', '\1' . listNum . style . ' ', ''))
      endfor
    endfunction

  ]])
