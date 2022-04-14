! Flarity default config:
!
! Fonts:
!   Coding:           FiraCode NF:                        https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode/
!   Writing:          agave NF:                           https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Agave/
!   Japanese support: Noto Sans CJK JP                    https://fonts.google.com/noto/specimen/Noto+Sans+JP
!   Icons support:    Material\\-Design\\-Iconic\\-Font   https://github.com/google/material-design-icons
!   Emojis support:   JoyPixels                           https://www.joypixels.com/
!   UNICODE support:  Unifont-JP                          http://unifoundry.com/unifont/

! Cycle main fonts.
!flarity.fonts        : FiraCode NF:style=Regular:pixelsize=14:antialias=true,agave NF:style=r:pixelsize=17:antialias=true,BlexMono NF:style=Book:pixelsize=17:antialias=true
!flarity.fonts        : FiraCode NF:style=Regular:pixelsize=14:antialias=true,,BlexMono NF:style=Book:pixelsize=17:antialias=true,CodeNewRoman NF:style=Regular:pixelsize=17:antialias=true,GoMono NF:style=Book:pixelsize=17:antialias=true

! FIXIT: Main fonts that can be cycled through.
!flarity.fonts         : FiraCode NF:style=Regular:pixelsize=14:antialias=true,BlexMono NF:style=Book:pixelsize=17:antialias=true

! Italic font.
flarity.italic        : VictorMono NF:style=Bold Italic:pixelsize=14:antialias=true:hinting=true
!flarity.italic        : Cartograph CF:style=Italic:pixelsize=14.5:antialias=true:hinting=true


! Bold font.
flarity.bold          : FiraCode NF:style=Bold:pixelsize=14:antialias=true:hinting=true

! Roman font.
flarity.roman         : JetBrainsMono Nerd Font:style=Bold:pixelsize=14:antialias=true:hinting=true

! FIXIT: Fonts fallback, in case of emojis and special icons.
!flarity.font_fallback : Material\\-Design\\-Iconic\\-Font:style=Design-Iconic-Font:pixelsize=16.25

! Time between blinks of the cursor.
flarity.blinktimeout  : 500

! ...
flarity.bellvolume    : 0

! Padding between the borders of the terminal.
flarity.padding       : 16

! Shape of the curosr.
flarity.cursorshape   : 5

! Character width scale.
flarity.cwscale       : 0.876

! Character height scale.
flarity.chscale       : 0.925

! Opacity of the terminal background.
flarity.opacity       : 1

! If ligatures are enabled or not.
flarity.ligatures     : 1
