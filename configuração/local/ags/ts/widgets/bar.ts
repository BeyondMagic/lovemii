import { CenterBox, Window, Box, Label } from 'resource:///com/github/Aylur/ags/widget.js';

import LabelDate from 'ts/labels/date';
import Battery from './battery';
import WindowManager from './window_manager';

const left = WindowManager.window.title_and_class

const center = LabelDate

const right = CenterBox({
	class_name: "center",
	center_widget: Label({
		label: '',
		hexpand: true
	}),
	end_widget: Box({
		class_name: "box",
		children: [
			Battery.number,
			WindowManager.workspaces.collapsed
		]
	})
})

const container = CenterBox({
	class_name: "container",

	visible: true,
	vertical: false,

	start_widget: left,

	center_widget: center,

	end_widget: right,
})


/*
 * The bar of the main monitor.
 */
function Bar (monitor: number) {
	return Window({
		name: `bar-${monitor}`,
		exclusivity: 'exclusive',
		visible: true,
		anchor: ['top', 'left', 'right'],
		child: container
	})
}

export default Bar
