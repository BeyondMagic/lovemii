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

		workspaces : Array<{
			id : number
			name : string
		}>
	}
	common : Array<{
		find : Array<string>
		replace : string
	}>
}

declare module "*.toml" {
  const content: Assets;
  export default content;
}
