# Filter using find subcommand.
export def "filter find" [
	...terms: any # Terms to search.
]: list<record<any>> -> list<record<any>> {
	$in | filter { $in | find ...$terms | is-not-empty }
}
