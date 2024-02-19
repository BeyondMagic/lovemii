import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import data from "../../assets/data.toml"

type Vertical = 'top' | 'bottom'
type Horizontal = 'left' | 'right'

function draw (context : any, vertical : Vertical, horizontal : Horizontal, size : number) {
	switch (vertical + horizontal) {
		case 'topleft':
			context.arc(size, size, size, Math.PI, 3 * Math.PI / 2)
			context.lineTo(0, 0)
		break

		case 'topright':
			context.arc(0, size, size, 3 * Math.PI / 2, 2 * Math.PI)
			context.lineTo(size, 0)
		break

		case 'bottomleft':
			context.arc(size, 0, size, Math.PI / 2, Math.PI)
			context.lineTo(0, size)
		break

		case 'bottomright':
			context.arc(0, 0, size, 0, Math.PI / 2)
			context.lineTo(size, size)
		break
	}

	context.closePath()

	const background = data.settings.background
	context.setSourceRGBA(background.red, background.green, background.blue, background.alpha)
	context.fill()

}

function RoundedCorner (vertical: Vertical, horizontal: Horizontal, classname : string) {
	return Widget.DrawingArea({
		class_name: classname,
		vpack: vertical.includes('top') ? 'start' : 'end',
		hpack: horizontal.includes('left') ? 'start' : 'end',

		setup (widget) {

			const size = data.settings.windows.screen_corner.size

			widget.set_size_request(size, size)

			widget.connect('draw', (_, cr) => draw(cr, vertical, horizontal, size))
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
