
# MS Windows specificities

## MS Windows Terminal settings

Enable `<c-enter>` and `<s-ender>` for Windows Terminal config in settings.json
```json
"actions": [
  {
    "keys": "ctrl+enter",
    "command": { "action": "sendInput", "input": "\u001b[13;5u" }
  },
  {
    "keys": "shift+enter",                 
    "command": { "action": "sendInput", "input": "\u001b[13;2u" }
  }
]
```
See:
  - https://www.reddit.com/r/neovim/comments/14rwpi2/windows_terminal_ccr_keymap_not_working/
  - https://vi.stackexchange.com/questions/43951/how-to-map-enter-ctrl-enter-and-shift-enter-in-neovim-nvim-cmp

 
