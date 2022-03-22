#!/usr/bin/env sh

# 1. Set main variables.
{

  # A. Main path of icons.
  icons="$HOME/.local/share/icons"

  #if mountpoint -q /mnt/pendrive; then

  #  pendrive_status="IMG:$icons/camera-off.svg\tUmount Pendrive\tdoas -- umount /mnt/pendrive"

  #else

  #  pendrive_status="IMG:$icons/camera-plus.svg\tMount Pendrive (/dev/sdc1)\tdoas -- mount -o umask=0,uid=nobody,gid=nobody /dev/sdc1 /mnt/pendrive"

  #fi

}

# 2. Retrieve command to execute.
command="$(echo "
IMG:$icons/three-menu.svg\tメニュー\teww update menu_is_open=true && eww open menu-central

IMG:$icons/box.svg\tパッケージを更新する\teww update menu_is_open=true && eww open menu-central
" \
| sed -re '1d;$d' | xmenu -p 80x800)"

# II. Execute command in fly.
eval "$command"
