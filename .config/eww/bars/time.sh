#!/usr/bin/env sh

n () {

  echo "(label :class 'normal' :text '$1')"

}

last_part="(label :class 'last' :text ' %a%d')"
separator_type="(label :class 'special' :text ':')"

date +"$(n '%H')$separator_type$(n '%M')$separator_type$(n '%S')$last_part"
