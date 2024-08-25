export-env {
	# For scripts of the desktop..
	$env.DESKTOP_NAME = 'lovemii'

	# For faciliate reference of this folder.
	$env.DESKTOP_SERVICE_MANAGER = ($env.HOME | path join .config/nushell/scripts/service_manager.nu)

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
	$env.MRU_File = $"($env.HOME)/.cache/vim_mru_files"

	# XDG default folder for configuration files.
	$env.XDG_CONFIG_HOME = $"($env.HOME)/.config"
	#$env.XDG_DATA_DIRS = $"($env.HOME)/.local/share"

	# To put trash files in here instead of removing them out of existence.
	$env.TRASH = $"($env.HOME)/.local/trash"

	# AUR package manger configuration files.
	$env.PARU_CONF = $"($env.XDG_CONFIG_HOME)/paru/paru.conf"

	# For Rust installatio and configuration.
	$env.CARGO_HOME = $"($env.XDG_CONFIG_HOME)/cargo"

	# Possible fix for Steam.
	$env.QT_QPA_PLATFORM = 'wayland'

	# For gnupg configuration files.
	#$env.GNUPGHOME = $"($env.XDG_CONFIG_HOME)/gnupg"

	# Add global path for Bun.
	$env.BUN_INSTALL = $"($env.HOME)/.bun"
}

# Load the environment variables of dune.
export def dune_ocaml []: nothing -> any {
	exec /home/dream/.opam/opam-init/init.sh
}
