return {
  vim.cmd [[
    command! E :Neotree position=current
    command! Explorer :Neotree position=current

    command! HeaderPromote call HeaderPromte()
    command! HeaderDemote call HeaderDemote()

    command! KeyMaps :call utils#KeyMaps()
    " save and quit
    " command! W :w!
    command! Q :q
    command! Qa :qa

    cnoreabbrev <silent> W w 
    cnoreabbrev <silent> ww w!
    cnoreabbrev <silent> wwa wa!
    cnoreabbrev <silent> xx x!
    cnoreabbrev <silent> xxa xa!
    cnoreabbrev <silent> qq q!
    cnoreabbrev <silent> qqa qa!
    cnoreabbrev <silent> ee e!

    command! -nargs=0 -range=% Number <line1>,<line2>s/^\s*\zs/\=(line('.') - <line1>+1).'. '
  ]],
}
