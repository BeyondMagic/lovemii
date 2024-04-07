import { Icon, Button } from "resource:///com/github/Aylur/ags/widget.js"
import data from "../../assets/data.toml"
import { execAsync } from "resource:///com/github/Aylur/ags/utils.js"

export const button = Button({
	class_name: 'screenshot',

	on_primary_click(self, event) {
		execAsync([ 'screenshot' ])
	},

	child: Icon({
		class_name: 'icon',
		size: data.settings.icon_size,
		icon: 'tool-screenshot',
	}),

})

export default button
