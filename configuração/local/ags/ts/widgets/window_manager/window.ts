import { Label, Box } from 'resource:///com/github/Aylur/ags/widget.js';
import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';

const max_string_n = 75

const window_class = Label({
	class_name: 'class',

	label: Hyprland
		.active
		.client
		.bind('class')
		.transform(c => c.substring(0, max_string_n))
})

const window_title = Label({
	class_name: 'title',

	label: Hyprland
		.active
		.client
		.bind('title')
		.transform(title => title.substring(0, max_string_n)),
})

const window_class_title = Box({

	class_name: 'window',

	visible: Hyprland
		.active
		.client
		.bind('address')
		.transform(addr => !!addr),

	children: [
		window_class,
		window_title
	]
})

const window = {
	title: window_title,
	class: window_class_title,
	title_and_class: window_class_title
}

export default window
