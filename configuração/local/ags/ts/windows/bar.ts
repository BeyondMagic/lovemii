import { CenterBox, Window, Box } from 'resource:///com/github/Aylur/ags/widget.js'

import label_date from '../labels/date'

import battery from '../widgets/battery'
import window_manager from '../widgets/window_manager'
import wifi from 'ts/widgets/wifi'
import screenshot from 'ts/widgets/screenshot'

const left = window_manager.window.class_title

const center = label_date

const right = () => Box({
	class_name: "right",
	hpack: 'end',
	children: [
		screenshot,
		wifi.icon,
		window_manager.workspaces.collapsed,
		battery.box(),
	]
})

const container = () => CenterBox({
	class_name: "container",

	visible: true,
	vertical: false,

	start_widget: left,

	center_widget: center,

	end_widget: right(),
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
		child: container()
	})
}

export default Bar
