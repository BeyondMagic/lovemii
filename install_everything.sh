#/usr/bin/env sh
#
# TODO: Finish all of this.
#
# BeyondMagic UNLICENSE https://github.com/beyondmagic/magiCK/

R="$(tput sgr0)"    # Reset.
B="$(tput bold)"    # Bold.
W="$(tput setaf 7)" # White.
G="$(tput setaf 8)" # Gray.

# Print a header.
header () {

  echo "  $B$W$1$R"

}

# Print a section.
section () {

  echo "    $B$G$1$R"

}

# Print the text by fixing the width.
text () {

  left="      "

  food="$1"

  limit_width="$(( ${#left} - $(tput cols)))"

  echo "$food" | sed -r "s/^/$left/"

}

case $1 in

  all)

  ;;

  packages)

    header  "Packages for this Arch-based (GNU+Linux) distribution configuration:"

    section "GNU+coreutils"
    text    "For many scripts I've written."

    section "advcpmv https://github.com/jarun/advcpmv"
    text    "cp and mv with progress bar."

    section "libxft-bgra"
    text    "Suckless utilities that need UNICODE support."

    section "fcitx5-configtool fcitx5-gtk fcitx5-material-color fcitx5-qt fcitx5-mozc-ut"
    text    "Input in Japanese."

  ;;

  dots)

  ;;

  help)

  ;;

  # Link the dotfiles from this root folder to the matching paths.
  link)

    # ln -sf

  ;;

  *)

  ;;

esac



# Install packages...

# Install configs...
# "+ zsh : Main shell."
# "+ xbindkeys : Keybinds."
# "+ pulseaudio + alsa-card-profiles + alsa-firmware + alsa-lib + alsa-plugins + alsa-utils + pulseaudio-alsa : Sound and output."
# "+ xorg-xrdb : For XResources."
# "+ polkit-dumb-agent-git : For polkit..."
# "+ neovim-nightly-bin : Editor of text."
# "+ sddm + sddm-runit : It's something like that."
# "+ xsettingsd : Simple X11 GTK server."
# "+ 915resolution : For grub resolution."
# ""
# "**Language Servers:**"
# "+ clang + llvm-libs + llvm : To build ccls."
# "+ node + npm : For JS applications and some language servers."
# "+ + `doas -- npm i -g`"
# "+ + + `vscode-langservers-extracted` : CSS + SCSS."
# "+ + + `typescript typescript-language-server` : Javascript + Typescript."
# "+ vale : Parse English..."
# ""
# "**Programs:**"
# "+ [colorpicker](ihttps://github.com/BeyondMagic/colorpicker) : To print random colouring from input."
# "+ [notify-send.sh](https://github.com/vlevit/notify-send.sh) & libnotify : Notification for the system."
# "+ [lolcat](https://github.com/jaseg/lolcat) : To print random colouring from input."
# "+ selectdefaultapplication : Select default application for xdg."
# "+ polkit-dumb-agent-git : for GPARTED and such programs."
# "+ paru : Package manager for AUR."
# "+ dwm : Window Manager for the system."
# "+ slop : Selection query for stdout."
# "+ xdotool : To handle windows independently of dwm."
# "+ imagemagick : To modify images and as lib for programs."
# "+ exa : Colourful ls."
# "+ [lemonbar](https://github.com/PH111P/bar) (special fonts support) : For bars."
# "+ nnn : File manager."
# "+ scrot : Take screenshot."
# "+ nsxiv : Image viewer."
# "+ xwallpaper : To set wallpaper."
# "+ dunst + libnotify : Notification viewer."
# "+ [picom](https://github.com/pijulius/picom) (animations + no artifacts) : Compositor for windows."
# "+ ncmpcpp : MPD viwer."
# "+ mpd : Music server."
# "+ mpdscribble : Connect MPD to last.fm."
# "+ dash, dashbinsh : Faster shell."
# "+ dmenu : Submenu for X11."
# "+ st : Terminal."
# "+ unclutter : Make cursor disappear in a few seconds."
# "+ skippy-xd : Handle all windows."
# "+ telegram-desktop : Telegram."
# "+ gimp : Image editor."
# "+ youtube-dl : To download youtube videos."
# "+ mpv : Video viewer."
# "+ zsh-syntax-highlighting zsh-autosuggestions : ZSH plugins."
# "+ xgetres : To get XResources definitions."
# "+ zathura zathura-pdf-poppler zathura-cb : To read pdf and such<F5>."
# "+ tokei : Read source-code."
# "+ light-server : For WEB development."
# "+ glava : Audio visualizer."
# ""
# "**Fonts:**"
# "+ ttf-fira-code : For terminals."
# "+ noto-fonts-cjk-jp : For Japanese."
# "+ nerd-fonts-emoji : For lemon bars."
# "+ ttf-joypixels : For dmenu."
# "+ unifont-jp : For special characters."
# ""
# "**Builds:**"
# "+ [st](https://github.com/beyondmagic/st) : Terminal;"
# "+ [dwm](https://github.com/beyondmagic/dwm) : Window Manager;"
# "+ [colorpicker](https://github.com/BeyondMagic/mod-colorpicker) : Pick colour from the screen;"
# "+ [xnotify](https://github.com/beyondmagic/mod-xnotify) : FIFO notification server."
# "+ [91menu](https://github.com/beyondmagic/91menu) : Plan9-inspired menu."
# "+ [slock](https://github.com/beyondmagic/slock) : Lock Screen."
# "+ [dmenu](https://github.com/beyondmagic/dmenu) : Dynamic Menu for X11."
