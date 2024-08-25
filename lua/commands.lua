vim.cmd [[
    command! Nt :Neotree position=current
    command! Nexplorer :Neotree position=current
    command! E :Oil
    command! O :Oil
    command! Explorer :Oil

    command! HeaderPromote call HeaderPromte()
    command! HeaderDemote call HeaderDemote()

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
    cnoreabbrev <silent> xx x!
    cnoreabbrev <silent> xxa xa!
    cnoreabbrev <silent> qq q!
    cnoreabbrev <silent> qqa qa!
    cnoreabbrev <silent> ee e!

    command! -nargs=0 -range=% Number <line1>,<line2>s/^\s*\zs/\=(line('.') - <line1>+1).'. '
  ]]

vim.api.nvim_create_user_command('CopyPathAbs', ":lua require('utils').copy_absolute_path()", {})
vim.api.nvim_create_user_command('CopyPathRel', ":lua require('utils').copy_relative_path()", {})

-- return {}
