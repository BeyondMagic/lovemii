// import { Image } from "@girs/gtk-3.0"
// import { Pixbuf } from "@girs/gdkpixbuf-2.0"
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
})

// Make a map for each program class name to its respective kind.
// A kind is the name for a default desktop software,
// e.j: terminal, firefox, email, ...
const class_to_icon = new Map<string, string>()

// Evaluate the map.
for (const item of data.common)
	for (const name of item.find)
		class_to_icon.set(name, item.replace)

// Set the name of icon apart.
let _window_class_icon : any
const window_class_icon = Icon({
	hpack: 'center',
	class_name: 'icon',
	size: data.settings.icon_size,
	icon: Hyprland
		.active
		.client
		.bind('class')
		.transform(name => {

			const icon_name = class_to_icon.get(name)

			// When failed to find an icon for the theme,
			// - make label visible.
			// - set label name.
			// - make this icon invisible.
			if (!icon_name)
			{
				window_class_name.visible = true
				_window_class_icon.visible = false
				window_class_name.label = name
				return ''
			}

			// Found an icon from map, so:
			// - Set label invisible.
			// - Make this icon visible.
			window_class_name.visible = false
			_window_class_icon.visible = true

			return data.icons[icon_name] + '-symbolic'
		})
})
_window_class_icon = window_class_icon

// Icon class of the active window.
const window_class_icon_name = Box({
	class_name: 'class',

	children: [
		window_class_name,
		window_class_icon,
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
		window_class_icon_name,
		window_title
	]
})

const window = {
	title: window_title,
	class: window_class_title,
	title_and_class: window_class_title
}

export default window
