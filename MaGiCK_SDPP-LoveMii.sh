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

    section "advcpmv (https://github.com/jarun/advcpmv)"
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

    section "polkit-dumb-agent-git"
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
    text    "To code faster in CSS & SCSS."

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

    section "nsxiv (https://github.com/BeyondMagic/nmodsxiv)"
    text    "Image viewer."

    section "dunst"
    text    "Notification viewer."

    section "picom (https://github.com/pijulius/picom)"
    text    "Compositor for windows with animations."

    section "ncmpcpp"
    text    "MPD player viwer."

    section "mpd mopidy (pip: Mopidy-Listenbrainz Mopidy Mopidy-Autoplay Mopidy-Iris Mopidy-Listenbrainz Mopidy-Local Mopidy-MPD Mopidy-Scrobbler Mopidy-Spotify Mopidy-YouTube)"
    text    "Music server..."

    section "dash dashbinsh"
    text    "Faster shell."

    section "dmenu"
    text    "Submenu for X11."

    #section "skippy-xd"
    #text    "Handle all windows."

    section "telegram-desktop"
    text    "Telegram."

    section "gimp krita"
    text    "Image Editor and Digital Image Painter"

    section "yt-dlp"
    text    "To download youtube videos."

    section "mpv"
    text    "Video viewer."

    section "zsh-syntax-highlighting zsh-autosuggestions"
    text    "ZSH plugins."

    section "xgetres"
    text    "To get XResources definitions."

    section "foliate zathura zathura-pdf-poppler zathura-cb"
    text    "To read PDF and such documents."

    section "readarr-nightly"
    text    "To organise books library and such."

    section "latex-mk texlab perl-yaml-tiny perl-file-homedir"
    text    "For latex (which means everything related to documents."

    section "libreoffice"
    text    "To simply convert DOCX files to PDF..."

    section "tokei"
    text    "Read source-code"

    #section "light-server"
    #text    "For WEB development."

    section "glava"
    text    "Audio visualizer."

    section "unifont-jp noto-fonts-cjk-jp"
    text    "For Japanese characters."

    section "ttf-joypixels"
    text    "For emojis characters"

    section "ttf-fira-code"
    text    "For the terminal."

    section "flarity (https://github.com/beyondmagic/flarity)"
    text    "A modern ST build."

    section "dwm (https://github.com/beyondmagic/dwm)"
    text    "Window Manager."

    section "colorpicker (https://github.com/BeyondMagic/mod-colorpicker)"
    text    "Pick colour from the screen."

    section "xmenu (https://github.com/beyondmagic/xmenu)"
    text    "For context menu."

    #section "91menu (https://github.com/beyondmagic/91menu)"
    #text    "FIFO notification server."

    #section "xnotify (https://github.com/beyondmagic/mod-xnotify)"
    #text    "Plan9-inspired menu."

    section "slock (https://github.com/beyondmagic/slock)"
    text    "Lock Screen."

    section "dmenu (https://github.com/beyondmagic/dmenu)"
    text    "Dynamic Menu for X11."

    section "freezer-bin (pip: scdl)"
    text    "Deezer player and SoundCloud player."

    section "song-rec"
    text    "Identify playing song."

    section "xidlehook"
    text    "To control the idle usage."

    section "copyq"
    text    "To control the copy history."

    section "xbanish"
    text    "Hide mouse cursor conveniently."

    section "lbry-app-bin"
    text    "To manage LBRY and Odysee."

    section "mailspring"
    text    "To manage multiple emails."

    section "anki"
    text    "To learn a lot of things."

    section "lmms"
    text    "To manage sounds and create music."

    section "geogebra"
    text    "Mathematics graphical calculator."

    section "sxhkd"
    text    "For keybinds."

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
