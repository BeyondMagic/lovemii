import {CenterBox, Window, Box, Label} from 'resource:///com/github/Aylur/ags/widget.js';
import LabelDate from 'ts/labels/date';
import Battery from './bar/battery';
import { focused_title, workspaces } from './hyprland';

/*
 * The bar of the main monitor.
 */
const Bar = (monitor: number) => Window({
	name: `bar-${monitor}`,
	exclusivity: 'exclusive',
	visible: true,
	anchor: ['top', 'left', 'right'],
	child: CenterBox({
		class_name: "container",
		visible: true,
		vertical: false,
		start_widget: Box({
			child: focused_title,
		}),
		center_widget: LabelDate,
		end_widget: CenterBox({
			class_name: "center",
			center_widget: Label({
				label: '',
				hexpand: true,
			}),
			end_widget: Box({
				class_name: "box",
				children: [
					Battery.number,
					workspaces
				]
			})
		})
	}),
});

export default Bar;
