### Packages.

Essential:
+ coreutils.
+ libxft-bgra.
+ fcitx5 : Keyboard in Japanese and Brazilian Portuguese (ABNT2).
+ fcitx5-configtool, fcitx5-gtk, fcitx5-material-color, fcitx5-qt, fcitx5-mozc.
+ zsh : Main shell.
+ xbindkeys : Keybinds.
+ pulseaudio : Sound and output.

Programs:

+ [colorpicker](ihttps://github.com/BeyondMagic/colorpicker) : To print random colouring from input.
+ [notify-send.sh](https://github.com/vlevit/notify-send.sh) & libnotify : Notification for the system.
+ lolcat : To print random colouring from input.
+ selectdefaultapplication : Select default application for xdg.
+ polkit-dumb-agent-git : for GPARTED and such programs.
+ paru : Package manager for AUR.
+ dwm : Window Manager for the system.
+ slop : Selection query for stdout.
+ xdo, xdotool : To handle windows independently of dwm.
+ imagemagick : To modify images and as lib for programs.
+ exa : Colourful ls.
+ lemonbar (special fonts support)
+ nnn : File manager.
+ nsxiv : Image viewer.
+ feh : Wallpaper setter.
+ dunst : Notification viewer.
+ picom : Compositor for windows.
+ ncmpcpp : MPD viwer.
+ mpd : Music server.
+ mpdscribble : Connect MPD to last.fm.
+ dash, dashbinsh : Faster shell.
+ 91menu : Menu for X11.
+ dmenu : Submenu for X11.
+ st : Terminal.
+ unclutter : Make cursor disappear in a few seconds.
+ skippy-xd : Handle all windows.
+ telegram-desktop : Telegram.
+ gimp : Image editor.
+ youtube-dl : To download youtube videos.
+ mpv : Video viewer.

Fonts:
+ ttf-fira-code : For terminals.
+ noto-fonts-cjk-jp-vf : For Japanese.
+ nerd-fonts-complete : For lemon bars.

---

### Post-Installation Artix

Swap Memory:

Auto-login:

Using openrc its simple (should be similar for runit). Each virtual
console has its own config `/etc/runit/sv/agetty-ttyX/conf`, where **X** is between **1** and **5**.

Chose one (or create another one, at least 1-9 should be no problem) and
add `--autologin USERNAME` to the config string. This will make agetty to
autologin **USERNAME** on virtual console X.

Now, open `~/.zshrc` and add after the shebang (remember to replace
X in ttyX):

```zsh
[ $(tty) = "/dev/ttyX" ] && exec startx
```

this will start X when logged in on console X.

### nvim

Run **nvim** and then, `:PackerSync`.

### Firefox (Nightly)

Enable in `about:config`:

Install the following addons:
+ [Stylus](https://addons.mozilla.org/en-US/firefox/addon/styl-us/)
+ [ClearURLs](https://addons.mozilla.org/en-US/firefox/addon/clearurls/)
+ [Search by Image](https://addons.mozilla.org/en-US/firefox/addon/search_by_image/)
+ [Sidebery](https://addons.mozilla.org/en-US/firefox/addon/sidebery/)
+ [SponsorBlock for Youtube - Skip Sponsorships](https://addons.mozilla.org/en-US/firefox/addon/sponsorblock/)
+ [uBlock Origin](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/)

```
config.trim_on_minimize
gfx.webrender.enabled
toolkit.legacyUserProfileCustomizations.stylesheets
layout.css.backdrop-filter.enabled
layout.css.color-mix.enabled
```

On `about:support` click on `Open Directory` for **Local Directory**:

```
wget ....userChrome.css ...userContent.css
```






