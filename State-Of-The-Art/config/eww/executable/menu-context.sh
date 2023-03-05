#!/usr/bin/env sh
#
# João F. © BeyondMagic 2022 <koetemagie@gmail.com>

# 1. Set main variables.
{

  # A. Main path of icons.
  i="IMG:$HOME/.local/share/icons"

}

# 2. Retrieve command to execute.
command="$(echo "
$i/three-menu.svg\tメニュー\teww update menu_is_open=true && eww open menu-central
$i/macro.svg\tHover Mode\teww-switch reveal-bars
$i/box.svg\tパッケージを更新する\teww update menu_is_open=true && eww open menu-central
" \
| sed -re '1d;$d' | xmenu -p 80x780)"

# II. Execute command in fly.
eval "$command"
