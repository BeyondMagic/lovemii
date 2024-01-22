import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import LabelDate from 'ts/labels/date';

/*
 * The bar of the main monitor.
 */
const Bar = (monitor: number) => Widget.Window({
	name: `bar-${monitor}`,
	layer: 'top',
	exclusivity: 'exclusive',
	visible: true,
	anchor: ['top', 'left', 'right'],
	child: LabelDate,
});

export default Bar;
