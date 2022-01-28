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

    section "eww"
    text    "Widgets of the desktop."

    section "zsh"
    text    "Main shell."

    section "xbindkeys"
    text    "Keybinds."

    section "pulseaudio alsa-card-profiles alsa-firmware alsa-lib alsa-plugins alsa-utils pulseaudio-alsa"
    text    "Sound and output."

    section "xorg-xrdb"
    text    "For XResources."

    sextion "polkit-dumb-agent-git"
    text    "For polkit..."

    section "neovim-nightly-bin"
    text    "Editor of text."

    section "sddm sddm-runit"
    text    "Login manager."

    section "xsettingsd"
    text    "Simple X11 GTK server."

    section "clang llvm-libs llvm"
    text    "To code faster in C and C++."

    section "node npm"
    text    "For JS applications and some language servers."

    section "vscode-langservers-extracted"
    text    "To code faster in CSS SCSS."

    section "typescript typescript-language-server"
    text    "Javascript + Typescript."

    section "vale"
    text    "Write better English..."


    section "colorpicker (https://github.com/BeyondMagic/colorpicker)"
    text    "To print random colouring from input."

    section "notify-send.sh (https://github.com/vlevit/notify-send.sh)  libnotify"
    text    "Notication sender for the system."

    section "lolcat (https://github.com/jaseg/lolcat)"
    text    "To print random colouring from input."

    section "selectdefaultapplication"
    text    "Select default application for xdg."

    section "polkit-dumb-agent-git"
    text    "for GPARTED and such programs."

    section "paru"
    text    "Package manager for AUR."

    section "slop"
    text    "Selection query for stdout."

    section "xdotool"
    text    "To handle windows independently of the Windows Manager."

    section "imagemagick"
    text    "To modify images and as lib for programs."

    section "exa"
    text    "Colourful ls."

    section "nnn"
    text    "File manager."

    section "scrot"
    text    "Take screenshot."

    section "nsxiv"
    text    "Image viewer."

    section "dunst"
    text    "Notification viewer."

    section "picom (https://github.com/pijulius/picom)"
    text    "Compositor for windows with animations."

    section "ncmpcpp"
    text    "MPD player viwer."

    section "mpd"
    text    "Music server."

    section "mpdscribble"
    text    "Connect MPD to last.fm."

    section "dash dashbinsh"
    text    "Faster shell."

    section "dmenu"
    text    "Submenu for X11."

    section "st"
    text    "Terminal."

    section "unclutter"
    text    "Make cursor disappear in a few seconds."

    section "skippy-xd"
    text    "Handle all windows."

    section "telegram-desktop"
    text    "Telegram."

    section "gimp"
    text    "Image editor."

    section "yt-dlp"
    text    "To download youtube videos."

    section "mpv"
    text    "Video viewer."

    section "zsh-syntax-highlighting zsh-autosuggestions"
    text    "ZSH plugins."

    section "xgetres"
    text    "To get XResources definitions."

    section "zathura zathura-pdf-poppler zathura-cb"
    text    "To read PDF and such documents."

    section "tokei"
    text    "Read source-code"

    section "light-server"
    text    "For WEB development."

    section "glava"
    text    "Audio visualizer."

    section "unifont-jp noto-fonts-cjk-jp"
    text    "For Japanese characters."

    section "ttf-joypixels"
    text    "For emojis characters"

    section "ttf-fira-code"
    text    "For the terminal."

    section "flarity (https://github.com/beyondmagic/flarity)"
    text    "A modern st build."

    section "dwm (https://github.com/beyondmagic/dwm)"
    text    "Window Manager."

    section "colorpicker (https://github.com/BeyondMagic/mod-colorpicker)"
    text    "Pick colour from the screen."

    section "91menu (https://github.com/beyondmagic/91menu)"
    text    "FIFO notification server."

    section "xnotify (https://github.com/beyondmagic/mod-xnotify)"
    text    "Plan9-inspired menu."

    section "slock (https://github.com/beyondmagic/slock)"
    text    "Lock Screen."

    section "dmenu (https://github.com/beyondmagic/dmenu)"
    text    "Dynamic Menu for X11."

    section "deemix-gui"
    text    "Deezer player :)"

    section "song-rec"
    text    "Identify playing song."

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
