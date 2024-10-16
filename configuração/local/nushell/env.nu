# Nushell Environment Config File
#
# João Farias © BeyondMagic 2023 <beyondmagic@mail.ru>

# If you want previously entered commands to have a different prompt from the usual one,
# you can uncomment one or more of the following lines.
# This can be useful if you have a 2-line prompt and it's taking up a lot of space
# because every command entered takes up 2 lines instead of 1. You can then uncomment
# the line below so that previously entered commands show with a single `🚀`.
# $env.TRANSIENT_PROMPT_COMMAND = {|| "🚀 " }
# $env.TRANSIENT_PROMPT_INDICATOR = {|| "" }
# $env.TRANSIENT_PROMPT_INDICATOR_VI_INSERT = {|| "" }
# $env.TRANSIENT_PROMPT_INDICATOR_VI_NORMAL = {|| "" }
# $env.TRANSIENT_PROMPT_MULTILINE_INDICATOR = {|| "" }
# $env.TRANSIENT_PROMPT_COMMAND_RIGHT = {|| "" }

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')

$env.READER = 'sioyek'
$env.BROWSER = 'firefox-nightly'
$env.FILE = 'nnn'

$env.SSH_AGENT_PID = ^pidof ssh-agent | complete | get stdout | str trim
$env.SSH_AUTH_SOCK = "/tmp/ssh-agent.socket"

$env.XDG_DATA_HOME = ($env.HOME | path join ".local/share")
$env.XDG_CONFIG_HOME = ($env.HOME | path join ".config")
$env.XDG_CACHE_HOME = ($env.HOME | path join ".cache")

$env.PYTHONSTARTUP = ($env.XDG_CONFIG_HOME | path join "python/startup.py")

$env.NUPM_HOME = ($env.XDG_DATA_HOME | path join "nupm")
$env.TRASH = ($env.HOME | path join ".config")
$env.PARU_CONF = ($env.XDG_CONFIG_HOME | path join "paru/paru.conf")
$env.CARGO_HOME = ($env.XDG_CONFIG_HOME | path join "cargo")
# $env.GNUPGHOME = ($env.XDG_CONFIG_HOME | path join "gnupg")
$env.BUN_INSTALL = ($env.HOME | path join ".bun")

$env.SVDIR = $"($env.HOME)/.local/services"

$env.LC_TIME = 'ja_JP.UTF-8'
$env.LANG = 'pt_BR.UTF-8'
$env.LC_COLLATE = 'C.UTF-8'

$env.PATH = ($env.PATH | split row (char esep) | append $'($env.CARGO_HOME)/bin')
$env.PATH = ($env.PATH | split row (char esep) | append ".local/bin")
$env.PATH = ($env.PATH | split row (char esep) | append ".bun/bin")
$env.PATH = ($env.PATH | split row (char esep) | append $'($env.NUPM_HOME)/scripts' )
$env.PATH = ($env.PATH | split row (char esep) | append "projects/personal/linux/scripts/bin/")


# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
    "Path": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

# Directories to search for scripts when calling source or use
$env.NU_LIB_DIRS = [
    # FIXME: This default is not implemented in rust code as of 2023-09-06.
    ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
	#  
	($env.NUPM_HOME | path join "modules")
]

# Directories to search for plugin binaries when calling register
$env.NU_PLUGIN_DIRS = [
    # FIXME: This default is not implemented in rust code as of 2023-09-06.
    ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
]

def create_left_prompt [] {
    let home =  $nu.home-path

    # Perform tilde substitution on dir
    # To determine if the prefix of the path matches the home dir, we split the current path into
    # segments, and compare those with the segments of the home dir. In cases where the current dir
    # is a parent of the home dir (e.g. `/home`, homedir is `/home/user`), this comparison will 
    # also evaluate to true. Inside the condition, we attempt to str replace `$home` with `~`.
    # Inside the condition, either:
    # 1. The home prefix will be replaced
    # 2. The current dir is a parent of the home dir, so it will be uneffected by the str replace
    let dir = (
        if ($env.PWD | path split | zip ($home | path split) | all { $in.0 == $in.1 }) {
            ($env.PWD | str replace $home "~" | path split | last | prepend ' ' | str join)
        } else {
            ($env.PWD | path split | last)
        }
    )

    let path_color = (if (is-admin) { ansi red_bold } else { ansi green_bold })
    let separator_color = (if (is-admin) { ansi light_red_bold } else { ansi light_green_bold })
    let path_segment = $"($path_color)($dir)"

    $path_segment | str replace --all (char path_sep) $"($separator_color)(char path_sep)($path_color)"
}

def create_right_prompt [] {
	if $env.LAST_EXIT_CODE != 0 {
		[
			(ansi rb)
			($env.LAST_EXIT_CODE)
		] | str join
	} else {
		''
	}
}

# Use nushell functions to define your right and left prompt
$env.PROMPT_COMMAND = {|| create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = {|| create_right_prompt }
