type Assets = {
	settings : {
		max_title_length : number
		icon_size : number

		windows : {
			screen_corner : {
				size : number
			}
		}

		background : {
			red : number
			green : number
			blue : number
			alpha : number
		}
	}
	common : Array<{
		find : Array<string>
		replace : string
	}>
	icons : {
		[key: string] : string
		_unknown : string
	}
}

declare module "*.toml" {
  const content: Assets;
  export default content;
}
