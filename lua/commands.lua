return {
  vim.cmd [[
    command! E :Neotree position=current
    command! Explorer :Neotree position=current

    command! HeaderLevelIncrease call HeaderIncrease()
    command! HeaderLevelDecrease call HeaderDecrease()

    command! KeyMaps :call utils#KeyMaps()
    " save and quit
    " command! W :w!
    command! Q :q
    cnoreabbrev <silent> W w 
    cnoreabbrev <silent> ww w!
    cnoreabbrev <silent> wwa wa!
    cnoreabbrev <silent> xx x!
    cnoreabbrev <silent> xxa xa!
    cnoreabbrev <silent> qq q!
    cnoreabbrev <silent> qqa qa!
    cnoreabbrev <silent> ee e!
  ]],
}
