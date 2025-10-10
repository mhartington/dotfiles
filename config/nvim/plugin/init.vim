" Remapping <C-y>, just doesn't cut it.
"
let loaded_netrwPlugin = 1
if &term =~ 'xterm\|kitty\|alacritty\|tmux\|ghostty'
    let &t_Ts = "\e[9m"   " Strikethrough
    let &t_Te = "\e[29m"
    let &t_Cs = "\e[4:3m" " Undercurl
    let &t_Ce = "\e[4:0m"
endif
