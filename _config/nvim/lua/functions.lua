function Restart_Dunst()
  os.execute([[zsh -c ". $HOME/Base/aliasesrc; up_dunst"]])
  os.execute([[notify-send.sh -i /usr/share/icons/Adwaita/16x16/actions/folder-new-symbolic.symbolic.png 'Testing Dunst'"]])
end

function Restart_Zathura()
  os.execute([[zsh -c ". $HOME/Base/aliasesrc; up_zathura"]])
end

function Restart_XBindKeys()
  os.execute([[killall xbindkeys]])
  os.execute([[xbindkeys -f /home/iris/Base/xbindkeysrc]])
end

function Restart_XResources()
  os.execute[[xrdb ~/.config/xorg/XResources]]
end
