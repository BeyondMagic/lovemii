function Restart_Zathura()
  os.execute([[zsh -c ". ~/.config/zsh/aliasesrc; up_zathura"]])
end

function Restart_XBindKeys()
  os.execute([[killall xbindkeys]])
  os.execute([[xbindkeys -f ~/.config/xbindkeys/xbindkeysrc]])
end

function Restart_XResources()
  os.execute[[xrdb ~/.config/xorg/XResources]]
end
