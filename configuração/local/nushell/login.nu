# Nushell Environment Login File
#
# Configuration with login.nu
#
# If Nushell is used as a login shell, you can use a specific configuration file which is only sourced in this case. Therefore a file with name login.nu has to be in the standard configuration directory.
#
# The file login.nu is sourced after env.nu and config.nu, so that you can overwrite those configurations if you need. There is an environment variable $nu.loginshell-path containing the path to this file.
#
# João V. Farias © BeyondMagic 2024 <beyondmagic@mail.ru>

# For scripts of the desktop.
$env.DESKTOP_NAME = 'lovemii'

# XDG default folder for configuration files.
$env.XDG_CONFIG_HOME = $env.HOME + '/.config'

# Rust: package manager home and configuration.
$env.CARGO_HOME = $env.XDG_CONFIG_HOME + '/cargo'

# Python: set virtual environment.
$env.VIRTUAL_ENV = $env.XDG_CONFIG_HOME + '/python/packages/'

# Bun: home and configuration files.
$env.BUN_INSTALL = $env.XDG_CONFIG_HOME + '/bun'

# Activate fcitx5.
#$env.GTK_IM_MODULE = fcitx
$env.QT_IM_MODULE = 'fcitx'
$env.GLFW_IM_MODULE = 'ibus'
$env.XMODIFIERS = '@im=fcitx'
$env.GTK_USE_PORTAL = 1

# History path for less.
$env.LESSHISTFILE = '/dev/null'

# Supress accessibility warning from GNOME bus.
$env.NO_AT_BRIDGE = 1

# Defualt text editor.
$env.EDITOR = 'nvim'

# Default visual editor.
$env.VISUAL = 'nvim'

# Default application for file manager.
$env.FILE = 'nnn'

# Default application for reading files.
$env.READER = 'foliate'

# Default application for browser.
$env.BROWSER = 'firefox-nightly'

# Scale for Wayland (GTK)
$env.GDK_SCALE = 1

# DPI Scale for Wayland (GTK)
$env.GDK_DPI_SCALE = 1

# Enable Wayland for Firefox.
$env.MOZ_ENABLE_WAYLAND = 1
$env.MOZ_DBUS_REMOTE = 1

# Fix all Java issues.
$env._JAVA_AWT_WM_NONREPARENTING = 1

# Import SSH auth socket.
$env.SSH_AUTH_SOCK = '/tmp/ssh-agent.socket'

# For Neovim MRU plugin (latest files).
$env.MRU_File = $env.HOME + '/.cache/vim_mru_files'

# XDG default folder for data files.
$env.XDG_DATA_HOME = $env.HOME + '/.local/share'

# XDG cache folder.
$env.XDG_CACHE_HOME = $env.HOME + '/.cache'

# To put trash files in here instead of removing them out of existence.
$env.TRASH = $env.HOME + '/.local/trash'

# Paru: AUR package manager configuration.
$env.PARU_CONF = $env.XDG_CONFIG_HOME + '/paru/paru.conf'

# Possible fix for Steam.
$env.QT_QPA_PLATFORM = 'wayland'

# Language unix settings.
$env.LC_TIME = 'ja_JP.UTF-8'
$env.LANG = 'en_GB.UTF-8'
$env.LC_COLLATE = 'C.UTF-8'

# Glob to all wallpaper files.
$env.WALLPAPER_FILES = '~/armazenamento/imagens/paredepapel/desktop/**/*'

# Share local database between diferent personal systems.
# Useful for sioyek.
$env.PDF_USER_DATABASE = 'hana'

# nnn: default opener for files.
$env.NNN_OPENER = 'xdg-open.nu'

# Python: path of './.python_history':
$env.PYTHON_HISTORY = $env.XDG_DATA_HOME + '/python/history.txt'

# Python: startup file for Python.
$env.PYTHONSTARTUP = $env.XDG_CONFIG_HOME + '/python/startup.py'

# Runit: directory for serive manager (sv).
$env.SVDIR =  $env.HOME + '/.local/services'

# SSH: dynamic get the agent PID.
$env.SSH_AGENT_PID = ^pidof ssh-agent | complete | get stdout | str trim

# Link user binaries.
# By putting these new binary folders, they end up having higher priority.
$env.PATH = [
	# User's local binaries.
	($env.HOME + '/.local/bin/')
	# Rust: binaries of cargo, package manager.
	($env.CARGO_HOME + '/bin/')
	# Python: binaries of virtual environment.
	($env.VIRTUAL_ENV + '/bin/')
	# Bun: binaries.
	($env.BUN_INSTALL + '/bin/')
	# Nushell: binaries of nupm, package manager.
	#($env.NUPM_HOME + '/scripts/')
] ++ ($env.PATH | split row (char esep)) | str join (char esep)

# For gnupg configuration files.
#$env.GNUPGHOME = $env.XDG_CONFIG_HOME + '/gnupg'

# Load the environment variables of dune.
#export def dune_ocaml []: nothing -> any {
#	exec /home/dream/.opam/opam-init/init.sh
#}
