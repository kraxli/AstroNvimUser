vim.cmd [[
    command! Nt :Neotree position=current
    command! Nexplorer :Neotree position=current
    command! E :Oil
    command! O :Oil
    command! Explorer :Oil

    command! HeaderPromote call Header_promote()
    command! HeaderDemote call Header_demote()

    command! KeyMaps :call utils#KeyMaps()
    " save and quit
    " command! W :w!
    command! Q :q
    command! Qa :qa
    cnoreabbrev <silent> Q q 
    cnoreabbrev <silent> Qa qa 

    cnoreabbrev <silent> W w 
    cnoreabbrev <silent> Wa wa 
    cnoreabbrev <silent> ww w!
    cnoreabbrev <silent> wwa wa!
    cnoreabbrev <silent> X x
    cnoreabbrev <silent> Xa xa
    cnoreabbrev <silent> XA xA 
    cnoreabbrev <silent> xx x!
    cnoreabbrev <silent> Xx x!
    cnoreabbrev <silent> XX x!
    cnoreabbrev <silent> xxa xa!
    cnoreabbrev <silent> qq q!
    cnoreabbrev <silent> qqa qa!
    cnoreabbrev <silent> ee e!

    command! -nargs=0 -range=% Number <line1>,<line2>s/^\s*\zs/\=(line('.') - <line1>+1).'. '

    command! -range WordCount :lua vim.api.nvim_feedkeys('gvg<c-g><esc>', "v", false)
  ]]


-- WordCount visual selection key map: g<c-g>

vim.api.nvim_create_user_command('CopyPathAbs', ":lua require('utils').copy_absolute_path()", {})
vim.api.nvim_create_user_command('CopyPathRel', ":lua require('utils').copy_relative_path()", {})

vim.api.nvim_create_user_command('ShowPathAbs', ":lua require('utils').show_absolute_path()", {})
vim.api.nvim_create_user_command('Pwd', ":lua require('utils').copy_dir()", {})
vim.api.nvim_create_user_command('CopyDir', ":lua require('utils').copy_dir(false)", {})
vim.api.nvim_create_user_command('CopyDirQuotes', ":lua require('utils').copy_dir(true)", {})
-- vim.cmd.cnoreabbrev('wq', '<nop>')

-- Create the user command
-- vim.api.nvim_create_user_command(
--     'WordCount',
--     'g<c-g>',
--     {
--         desc = 'Count words in visual selection',
--         range = '%', -- Allow it to work on a range, e.g., :'<,'>VisualWordCount
--         bar = true,  -- Allow other commands after this one
--         mode = 'v',  -- Only available in visual mode (or visual line/block)
--     }
-- )

-- return {}
