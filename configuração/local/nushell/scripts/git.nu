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

# Root folder of the repository.
export def root []: nothing -> string {
	(^git rev-parse --show-cdup
	| path expand
	) + '/'
}

# Parse text of strings of files as paths.
def parse-files [base?: string]: string -> list<string> {
	let before = if ($base | is-empty) {
		root
	} else {
		$base
	}

	$in
	| lines
	| par-each {|path|
		let full = $before | path join $path
		if ($full | path type | is-not-empty) {
			ls --directory $full
			| first
		} else {
			{
				name: $full
				type: 'deleted'
				size: -1B
				modified: (date now)
			}
		}
	}
}

# Realpath fix.
def realpath []: string -> string {
	^realpath -s --relative-to='./' $in
}

# List untracked files.
export def 'list untracked' [
	base?: string # Root folder to find changes within.
]: nothing -> list<string> {
	let before = if ($base | is-empty) {
		root
	} else {
		$base
	}

	cd $before

	let result = ^git -c core.quotepath=false ls-files --others --exclude-standard
		| parse-files $base

	cd -

	$result
	| update name { realpath }
}

# List files with changes.
export def diff [
	base?: string # Root folder to find changes within.
	--untracked = true # Files not tracked yet by git.
]: nothing -> list<string> {

	let content_git = if ($base | is-empty) {
		^git -c core.quotepath=false diff --name-only
	} else {
		^git -c core.quotepath=false diff --name-only $base
	}

	mut tracked = $content_git
		| parse-files
		| default true tracked
		| update name { realpath }

	if $untracked {
		$tracked = $tracked ++ (
			list untracked $base
			| default false tracked
		)
	}

	$tracked
	| sort-by tracked modified
}

# Commit the changes.
export def commit [
	title?: string # Title of the commit.
	message?: string # Message of the commit.
]: nothing -> nothing {
	# Edit the commit title and message using default editor.
	if ($title | is-empty) {
		^git commit -S
	} else if ($message | is-empty) {
		^git commit -S -m $title
	} else {
		^git commit -S -m $title $message
	}
}

# See information of commits.
export def log []: nothing -> nothing {
	^git log --graph --reflog
}
