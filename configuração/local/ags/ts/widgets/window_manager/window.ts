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

// Load class icon.
function load_class_icon (icon : ReturnType<typeof Icon>) {
	const name = Hyprland.active.client.class

	const icon_name = class_to_icon.get(name)

	// When failed to find an icon for the theme,
	// - make label visible.
	// - set label name.
	// - make this icon invisible.
	if (!icon_name)
	{
		window_class_name.visible = true
		icon.visible = false
		window_class_name.label = name
		icon.icon = ''
		return
	}

	// Found an icon from map, so:
	// - Set label invisible.
	// - Make this icon visible.
	window_class_name.visible = false
	icon.visible = true

	icon.icon = icon_name + '-symbolic'
}

// Set the name of icon apart.
const window_class_icon = Icon({
	hpack: 'center',
	class_name: 'icon',
	size: data.settings.icon_size,
	setup: self => self
		.hook(Hyprland.active.client, self => load_class_icon(self))
})

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

function update_title_class () {
	load_class_icon(window_class_icon)
	window_title.label = Hyprland.active.client.title
}

const window = {
	title: window_title,
	class: window_class_icon_name,
	class_title: window_class_title,
	actions: {
		update_title_class
	}
}

export default window
