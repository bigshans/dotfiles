# setopt correct                                                # Auto correct mistakes
setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                               # Case insensitive globbing
setopt rcexpandparam                                            # Array expension with parameters
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt nobeep                                                   # No beep
setopt appendhistory                                            # Immediately append history instead of overwriting
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt autocd                                                   # if only directory path is entered, cd there.
autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit

bindkey -s '^o^p' "xdg-open . 1>/dev/null 2>/dev/null^M"
bindkey -s '^o^o' "vim^M"
bindkey -s '^o^l' "ranger^M"

eval "$(zoxide init zsh)"
