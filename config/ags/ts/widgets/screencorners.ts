import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Gtk from 'node_modules/@girs/gtk-3.0/gtk-3.0';
// import Utils from 'resource:///com/github/Aylur/ags/utils.js';

function RoundedCorner (vertical: 'top' | 'bottom', horizontal: 'left' | 'right', classname : string) {
	return Widget.DrawingArea({
		class_name: classname,
		vpack: vertical.includes('top') ? 'start' : 'end',
		hpack: horizontal.includes('left') ? 'start' : 'end',
		setup: (widget) => {
			const c = widget.get_style_context().get_property('background-color', Gtk.StateFlags.NORMAL);
			const r = widget.get_style_context().get_property('border-radius', Gtk.StateFlags.NORMAL);
			widget.set_size_request(r, r);

			widget.connect('draw', (_, cr) => {
				switch (vertical + horizontal) {
					case 'topleft':
						cr.arc(r, r, r, Math.PI, 3 * Math.PI / 2);
						cr.lineTo(0, 0);
					break;

					case 'topright':
						cr.arc(0, r, r, 3 * Math.PI / 2, 2 * Math.PI);
						cr.lineTo(r, 0);
					break;

					case 'bottomleft':
						cr.arc(r, 0, r, Math.PI / 2, Math.PI);
						cr.lineTo(0, r);
					break;

					case 'bottomright':
						cr.arc(0, 0, r, 0, Math.PI / 2);
						cr.lineTo(r, r);
					break;
				}

				cr.closePath();
				cr.setSourceRGBA(c.red, c.green, c.blue, c.alpha);
				cr.fill();
			})
		}
	});
}

/*
 * The bar of the main monitor.
 */
function Corner (anchor_vertical : 'top' | 'bottom', anchor_horizontal: 'left' | 'right') {
	return Widget.Window({
		class_name: 'widget-corner',
		name: `corner-${anchor_vertical}-${anchor_horizontal}`,
		layer: 'top',
		anchor: [anchor_vertical, anchor_horizontal],
		exclusivity: 'normal',
		visible: true,
		child: RoundedCorner(anchor_vertical, anchor_horizontal, 'corner-black'),
	});
}

export default Corner;
