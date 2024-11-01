export-env {
	# For scripts of the desktop.
	$env.DESKTOP_NAME = 'lovemii'

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

	# For gnupg configuration files.
	#$env.GNUPGHOME = $env.XDG_CONFIG_HOME + '/gnupg'
}

# Load the environment variables of dune.
#export def dune_ocaml []: nothing -> any {
#	exec /home/dream/.opam/opam-init/init.sh
#}
