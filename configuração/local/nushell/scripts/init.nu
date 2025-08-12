# System loader.
export use lovemii.nu

# Modules for standard commands of Nushell itself.
#export use ./standard/exec.nu *
export use ./standard/random.nu
#export use ./standard/filter.nu *
export use ./standard/str.nu

# Modules for external commands.
export use ./external/sv.nu
export use ./external/typst.nu
export use ./external/tokei.nu
export use ./external/git.nu
export use ./external/anac.nu
export use ./external/oracle.nu
export use ./external/gcal.nu *
#export use ./external/python.nu

export use miscelanous.nu *
export use package.nu
export use system.nu
export use emojis.nu
export use fork.nu
export use file.nu
export use wallpaper.nu
export use video.nu
export use music.nu
export use mount.nu
export use admin.nu
export use quotes.nu
export use editor.nu
export use prompt.nu

export use ~/projetos/pessoal/competitive-programming/script/pc.nu

export use ./themes/tokyo-night.nu

export alias fm = file manager
export alias rm = rm -i
export alias _ = echo $env.LAST
export alias find = find --no-highlight
export alias prolog = ^swipl
export alias calendar = gcal
export alias mv = mv --progress --verbose
export alias cp = cp --progress --verbose
