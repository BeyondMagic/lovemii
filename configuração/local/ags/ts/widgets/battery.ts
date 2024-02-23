import { Label } from 'resource:///com/github/Aylur/ags/widget.js';
import Battery from 'resource:///com/github/Aylur/ags/service/battery.js'

function draw_icon (label : ReturnType<typeof Label>, context : any) : void {

	const label_height = label.get_allocated_height()
	const label_width = label.get_allocated_width()

	const circle_size = 3

	const width = label_width - circle_size * circle_size
	const height = width / 2.25

	const x = (label_width - width) / 2
	const y = (label_height - height) / 2

	const radius = 6
	const degrees = Math.PI / 180

	const background = {
		red: 1 - Battery.percent / 100,
		green: 1,
		blue: Battery.percent / 100,
	}

	context.newSubPath()
	context.arc(x + width - radius, y + radius, radius, -90 * degrees, 0 * degrees)
	context.arc(x + width - radius, y + height - radius, radius, 0 * degrees, 90 * degrees)
	context.arc(x + radius, y + height - radius, radius, 90 * degrees, 180 * degrees)
	context.arc(x + radius, y + radius, radius, 180 * degrees, 270 * degrees)
	context.closePath()

	context.setSourceRGBA(background.red, background.green, background.blue, 0.15)
	context.fillPreserve()
	context.setSourceRGBA(background.red, background.green, background.blue, 0.5)
	context.setLineWidth(2)
	context.stroke()

	// Draw circle.
	context.save()
	context.arc(width + x + circle_size / 2, label_height / 2, circle_size, Math.PI * 3 / 2, Math.PI / 2)
	context.setSourceRGBA(background.red, background.green, background.blue, 0.5)
	context.fillPreserve()
	context.restore()
	context.stroke()


	// Freeing the context before returning from the callback
	context.$dispose()
}

function to_hex (c : number) : string {
	const hex = Math.floor(c).toString(16)

	return hex.length === 1 ? '0' + hex : hex
}

// Battery widget for the bar.
const markup_percentage = '<span fgalpha="75%">%</span>'

function colour (percentage : number) : string {
	const red = (1 - percentage / 100) * 255
	const green = 255
	const blue = percentage / 100 * 255

	const number = '<span foreground="#'
		+ to_hex(red)
		+ to_hex(green)
		+ to_hex(blue)
		+ '">'
		+ percentage
		+ markup_percentage
		+ '</span>'

	return number
}

const widget_number = Label({
	visible: Battery.bind('available'),
	class_name: Battery.
		bind('charging')
		.transform(charging => {
			return charging ? 'charging battery' : 'battery'
		})
	,
	use_markup: true,
	label: Battery
		.bind('percent')
		.transform(percentage => colour(percentage)),
	
	setup: self => self
		.connect('draw', (_, context) => draw_icon(self, context))
})

const battery = {
	number: widget_number
}

export default battery
