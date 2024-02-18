import { Label, Box, Icon } from 'resource:///com/github/Aylur/ags/widget.js'
import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js'
import data from "../../../assets/data.toml"

// Title of the active window.
const window_title = Label({
	class_name: 'title',

	truncate: 'end',
	max_width_chars: data.settings.max_title_length,

	label: Hyprland
		.active
		.client
		.bind('title')
})

// Class name of the active window.
const window_class_name = Label({
	class_name: 'name',

	truncate: 'end',
	max_width_chars: data.settings.max_title_length,

	label: Hyprland
		.active
		.client
		.bind('class')
})

// Make a map for each program class name to its respective kind.
// A kind is the name for a default desktop software,
// e.j: terminal, firefox, email, ...
const class_to_icon = new Map<string, string>()

// Evaluate the map.
for (const item of data.common)
	for (const name of item.find)
		class_to_icon.set(name, item.replace)

// Icon class of the active window.
const window_class_icon = Box({
	class_name: 'class',

	children: [
		window_class_name,
		// Icon({
		// 	size: data.settings.icon_size,

		// 	icon: Hyprland
		// 		.active
		// 		.client
		// 		.bind('class')
		// 		.transform(c => {
		// 			const icon_name = class_to_icon.get(c)
		// 			if (!icon_name)
		// 				return data.icons._unknown
		// 			return data.icons[icon_name]
		// 		})
		// })
	]
})

// Class and title of the active window.
const window_class_title = Box({

	class_name: 'window',

	visible: Hyprland
		.active
		.client
		.bind('address')
		.transform(addr => !!addr),

	children: [
		window_class_icon,
		window_title
	]
})

const window = {
	title: window_title,
	class: window_class_title,
	title_and_class: window_class_title
}

export default window
