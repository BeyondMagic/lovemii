<h1 align="center">Xorg</h1>

---

<h3 align="center">PACKAGES</h3>

**Essential:**
+ coreutils.
+ + [advcpmv](https://github.com/jarun/advcpmv) : cp and mv with progress bar.
+ libxft-bgra.
+ fcitx5-configtool, fcitx5-gtk, fcitx5-material-color, fcitx5-qt, fcitx5-mozc-ut : Input in Japanese.
+ zsh : Main shell.
+ xbindkeys : Keybinds.
+ pulseaudio + alsa-card-profiles + alsa-firmware + alsa-lib + alsa-plugins + alsa-utils + pulseaudio-alsa : Sound and output.
+ xorg-xrdb : For XResources.
+ polkit-dumb-agent-git : For polkit...
+ neovim-nightly-bin : Editor of text.
+ sddm + sddm-runit : It's something like that.
+ xsettingsd : Simple X11 GTK server.

**Language Servers:**
+ clang + llvm-libs + llvm : To build ccls.
+ node + npm : For JS applications and some language servers.
+ + `doas -- npm i -g`
+ + + `vscode-langservers-extracted` : CSS + SCSS.
+ + + `typescript typescript-language-server` : Javascript + Typescript.

**Programs:**
+ [colorpicker](ihttps://github.com/BeyondMagic/colorpicker) : To print random colouring from input.
+ [notify-send.sh](https://github.com/vlevit/notify-send.sh) & libnotify : Notification for the system.
+ [lolcat](https://github.com/jaseg/lolcat) : To print random colouring from input.
+ selectdefaultapplication : Select default application for xdg.
+ polkit-dumb-agent-git : for GPARTED and such programs.
+ paru : Package manager for AUR.
+ dwm : Window Manager for the system.
+ slop : Selection query for stdout.
+ xdotool : To handle windows independently of dwm.
+ imagemagick : To modify images and as lib for programs.
+ exa : Colourful ls.
+ [lemonbar](https://github.com/PH111P/bar) (special fonts support) : For bars.
+ nnn : File manager.
+ scrot : Take screenshot.
+ nsxiv : Image viewer.
+ xwallpaper : To set wallpaper.
+ dunst + libnotify : Notification viewer.
+ [picom](https://github.com/pijulius/picom) (animations + no artifacts) : Compositor for windows.
+ ncmpcpp : MPD viwer.
+ mpd : Music server.
+ mpdscribble : Connect MPD to last.fm.
+ dash, dashbinsh : Faster shell.
+ dmenu : Submenu for X11.
+ st : Terminal.
+ unclutter : Make cursor disappear in a few seconds.
+ skippy-xd : Handle all windows.
+ telegram-desktop : Telegram.
+ gimp : Image editor.
+ youtube-dl : To download youtube videos.
+ mpv : Video viewer.
+ zsh-syntax-highlighting zsh-autosuggestions : ZSH plugins.
+ xgetres : To get XResources definitions.
+ zathura zathura-pdf-poppler zathura-cb : To read pdf and such<F5>.

**Fonts:**
+ ttf-fira-code : For terminals.
+ noto-fonts-cjk-jp : For Japanese.
+ nerd-fonts-emoji : For lemon bars.
+ ttf-joypixels : For dmenu.
+ unifont-jp : For special characters.

**Builds:**
+ [st](https://github.com/beyondmagic/st) : Terminal;
+ [dwm](https://github.com/beyondmagic/dwm) : Window Manager;
+ [colorpicker](https://github.com/BeyondMagic/mod-colorpicker) : Pick colour from the screen;
+ [xnotify](https://github.com/beyondmagic/mod-xnotify) : FIFO notification server.
+ [91menu](https://github.com/beyondmagic/91menu) : Plan9-inspired menu.
+ [slock](https://github.com/beyondmagic/slock) : Lock Screen.
+ [dmenu](https://github.com/beyondmagic/dmenu) : Dynamic Menu for X11.

---

<h3 align="center">POST-INSTALLATION ARTIX RUNIT</h3>

##### sddm

Run this to link the `xsessions` folder and add `lovemii` executable, then pass all the configuration of sddm to the current system.

```zsh
# cp "$HOME/git/config/lovemii" /usr/bin/
# mkdir -p /usr/share/xsessions
# cp -rf "$HOME/git/config/usr/share/xsessions/*" /usr/share/
# cp -rf "$HOME/git/config/usr/share/sddm/themes/*" /usr/share/sddm/themes/
# cp -rf "$HOME/git/config/etc/sddm.conf" /etc/sddm.conf
```

---

<h2 align=-"center">SPECIAL PROGRAMS</h2>

### NeoVim

<p align="center">
  <img src="/.github/neovim.png" alt="Preview of NeoVim">
</p>

First, copy the configuration of NeoVim to its config folder.

`$ cp -rf ~/git/config/_config/nvim ~/.config/nvim/`

Run **nvim** and then, `:PackerSync`.

### Firefox (Beta)

<p align="center">
  <img src="/.github/firefox.png" alt="Preview of home page of Firefox">
</p>

Install the following addons:
+ [Stylus](https://addons.mozilla.org/en-US/firefox/addon/styl-us/)
+ [ClearURLs](https://addons.mozilla.org/en-US/firefox/addon/clearurls/)
+ [Search by Image](https://addons.mozilla.org/en-US/firefox/addon/search_by_image/)
+ [Sidebery](https://addons.mozilla.org/en-US/firefox/addon/sidebery/)
+ [SponsorBlock for Youtube - Skip Sponsorships](https://addons.mozilla.org/en-US/firefox/addon/sponsorblock/)
+ [uBlock Origin](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/)

Enable the following in `about:config`:
```
config.trim_on_minimize
gfx.webrender.enabled
toolkit.legacyUserProfileCustomizations.stylesheets
layout.css.backdrop-filter.enabled
layout.css.color-mix.enabled
```

On `about:support` click on `Open Directory` for **Local Directory**:

TODO: fix to my current repository.
```
wget ....userChrome.css ...userContent.css
```

Set the homepage to [mod-startpage](https://github.com/BeyondMagic/mod-startpage).

### Keyboard

On `/etc/vconsole.conf`, to set Portuguese (ABNT2):

```zsh
KEYMAP=abnt2
```

---

<h1 align="center">WayLand</h1>

TODO:: new life
+ EFL
+ WayLand
+ (some window manager that is very modular and lightweight)
+ (some bars that is very modular and lightweight)
+ ...

