# Filter using find subcommand.
export def "filter find" [
	...terms: any # Terms to search.
]: list<any> -> list<any> {
	$in | filter { $in | find ...$terms | is-not-empty }
}
