local applications = {
    launcher = "rofi -show drun -matching fuzzy",
    terminal = "kitty",
    run_shell = 'rofi rofi -show drun -run-shell-command \'kitty -e zsh -ic "{cmd} && read"\''
}

return applications

