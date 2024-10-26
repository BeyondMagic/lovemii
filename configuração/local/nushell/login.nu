# Configuration with login.nu
#
# If Nushell is used as a login shell, you can use a specific configuration file which is only sourced in this case. Therefore a file with name login.nu has to be in the standard configuration directory.
#
# The file login.nu is sourced after env.nu and config.nu, so that you can overwrite those configurations if you need. There is an environment variable $nu.loginshell-path containing the path to this file.
#
# What about customizing interactive shells, similar to .zshrc? By default config.nu is only loaded in interactive shells, not scripts.

