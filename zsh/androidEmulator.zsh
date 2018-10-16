function selectAvd() {
    echo 'Please enter your choice (0 to close): '
    opts=($(emulator -list-avds -maxdepth 1 -print0 | xargs -0))
    select opt in "${opts[@]}"; do 
        if (( REPLY > 0 && REPLY <= ${#opts[@]} )) ; then
             emulator -avd $opt
        elif (( REPLY <  1)) ; then
             break
        else
            echo "Invalid option."
        fi
    done    
}

alias avd="selectAvd"
