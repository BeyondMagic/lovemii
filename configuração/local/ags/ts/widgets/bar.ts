import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import LabelDate from 'ts/labels/date';
//import { Workspaces, focusedTitle } from './hyprland';

/*
 * The bar of the main monitor.
 */
const Bar = (monitor: number) => Widget.Window({
	name: `bar-${monitor}`,
	// layer: 'top',
	exclusivity: 'exclusive',
	visible: true,
	anchor: ['top', 'left', 'right'],
	child: Widget.CenterBox({
		name: "container",
		visible: true,
		// spacing: 8,
		vertical: false,
		start_widget: Widget.Label(''),
		center_widget: LabelDate,
		end_widget: Widget.Label(''),
	}),
});

export default Bar;
