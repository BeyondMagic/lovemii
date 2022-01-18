#!/usr/bin/env sh

n () {

  echo "(label :class 'normal' :text '$1')"

}

first_part="(label :class 'first' :text '%a %b %d')"
separator_time="(label :class 'special' :text ' - ')"
separator_type="(label :class 'special' :text ':')"

date +"$first_part$separator_time$(n '%H')$separator_type$(n '%M')$separator_type$(n '%S')"
