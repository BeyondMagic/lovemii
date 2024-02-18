import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import data from "../../assets/data.toml"

function RoundedCorner (vertical: 'top' | 'bottom', horizontal: 'left' | 'right', classname : string) {
	return Widget.DrawingArea({
		class_name: classname,
		vpack: vertical.includes('top') ? 'start' : 'end',
		hpack: horizontal.includes('left') ? 'start' : 'end',

		setup (widget) {

			const background = data.settings.background
			const size = data.settings.windows.screen_corner.size

			widget.set_size_request(size, size);

			widget.connect('draw', (_, cr) => {

				switch (vertical + horizontal) {
					case 'topleft':
						cr.arc(size, size, size, Math.PI, 3 * Math.PI / 2);
						cr.lineTo(0, 0);
					break;

					case 'topright':
						cr.arc(0, size, size, 3 * Math.PI / 2, 2 * Math.PI);
						cr.lineTo(size, 0);
					break;

					case 'bottomleft':
						cr.arc(size, 0, size, Math.PI / 2, Math.PI);
						cr.lineTo(0, size);
					break;

					case 'bottomright':
						cr.arc(0, 0, size, 0, Math.PI / 2);
						cr.lineTo(size, size);
					break;
				}

				cr.closePath();
				cr.setSourceRGBA(background.red, background.green, background.blue, background.alpha);
				cr.fill();
			})
		}
	})
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
