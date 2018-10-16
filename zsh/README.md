## .zsh stuff
### Themes
- powerlevel9k
- brogramer
- paraíso dark

### Custom .zsh files
- autosuggestions.zsh - Necessary to set bindkey '^[execute' at iTerm2 preferences
- androidEmulator.zsh - Necessary to set the following exports at .zshrc
```
export PLATFORM_TOOLS=/Users/$USER/Library/Android/sdk/platform-tools
export ANDROID_EMULATOR=/Users/$USER/Library/Android/sdk/emulator
export PATH=$PLATFORM_TOOLS:$ANDROID_EMULATOR:$PATH
```
- iTrem2-ssh.zsh - Necessary to configure iTrem2 profiles

### Reminder
`cd $ZSH_CUSTOM` -> .oh-my-zsh/custom
