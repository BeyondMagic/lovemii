#!/usr/bin/env nu
#
# sgasse © 2023
# João Farias © BeyondMagic <beyondmagic@mail.ru> 2024
#
# Custom command to conveniently edit commits in the history.
#
# Use with:
# `use <repo_root>/git/git_edit.nu`
#
# `git edit` starts an interactive rebase to edit a commit in the history, which
# can be selected from a complection list. An example completion list may look
# like this:
#
# >| git edit
# 2024d52  upgrade to nu 0.77 (#413)
# 10bde06  Fix since last release script (#412)
# 18deb3d  Add `nu-cmd-lang` to `nu_release.nu` (#411)
# e95f609  Updated conda script to default to base if no arg given (#409)
# 34235ef  Replace deprecated `str collect` command (#410)
# 06dd125  Revert "conda activate base if env_name not given (#400)" (#408)
# ...

# Helper command to get commit of this branch only list to edit
def "nu-complete git commits" [] {
	^git log --pretty="%h %s"
	| lines
	| parse "{value} {description}"
}

# Edit a commit by selecting it as only commit to edit in an interactive rebase
# run non-interactively.
export def edit [
    commit: string@"nu-complete git commits" # Commit-hashed code to edit.
]: nothing -> nothing {
	# We use `sed` to replace `pick` with `edit`.
	# `0,/pick/` restricts the sustitution to the range from the beginning until
	# the first occurence of `pick`.
	GIT_SEQUENCE_EDITOR="sed -i -e '0,/pick/{s/pick/edit/}'" ^git rebase -i $"($commit)^1"
}

# List untracked files.
export def untracked []: nothing -> list<string> {
	^git ls-files --others --exclude-standard
	| lines
	| par-each {|path|
		ls --directory $path
		| first
	}
}
