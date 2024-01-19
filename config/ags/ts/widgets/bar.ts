import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import date from '../labels/date';
// import volume from '../labels/volume';

/*
 * The bar of the main monitor.
 */
const Bar = (monitor: number) => Widget.Window({
	name: `bar-${monitor}`,
	anchor: ['top', 'left', 'right'],
	child: Widget.Label().bind('label', date),
});

export default Bar;
