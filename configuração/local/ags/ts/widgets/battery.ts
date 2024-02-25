import { Label } from 'resource:///com/github/Aylur/ags/widget.js';
import Battery from 'resource:///com/github/Aylur/ags/service/battery.js'

type Color = {
	red : number
	green : number
	blue : number
	alpha : number
}

// Make a rounded rectangle.
function make_rounded_circle ({
	context,
	x,
	y,
	width,
	height,
	radius,
	degrees,
	color
} : {
	context: any
	x : number
	y : number
	width : number
	height : number
	radius : number
	degrees : number
	color : Color
}) : void {
	context.newSubPath()
	context.arc(x + width - radius, y + radius, radius, -90 * degrees, 0 * degrees)
	context.arc(x + width - radius, y + height - radius, radius, 0 * degrees, 90 * degrees)
	context.arc(x + radius, y + height - radius, radius, 90 * degrees, 180 * degrees)
	context.arc(x + radius, y + radius, radius, 180 * degrees, 270 * degrees)
	context.closePath()
	context.setSourceRGBA(color.red, color.green, color.blue, color.alpha)
	context.fillPreserve()
}

// Make a stroke (border) for the current stroke.
function make_stroke ({
	context,
	stroke,
	color
} : {
	context : any
	stroke : number
	color? : Color
}) : void {

	// If stroke is 0, no reason to set color.
	if (color)
		context.setSourceRGBA(color.red, color.green, color.blue, color.alpha)
	context.setLineWidth(stroke)
	context.stroke()
}

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

	const color = {
		red: 1 - Battery.percent / 100,
		green: 1,
		blue: Battery.percent / 100,
		alpha: 0.1,
	}

	make_rounded_circle({
		context,
		x,
		y,
		width,
		height,
		radius,
		degrees,
		color,
	})

	make_stroke({
		context,
		stroke: 2,
		color: {
			...color,
			alpha: 0.5
		}
	})

	const padding = 3
	make_rounded_circle({
		context,
		x: x + padding,
		y: y + padding,
		width: Battery.percent / 100 * (width - padding * 2),
		height: height - padding * 2,
		radius,
		degrees,
		color: {
			...color,
			alpha: 0.1
		},
	})

	make_stroke({
		context,
		stroke: 0
	})

	// Draw circle.
	context.save()
	context.arc(width + x + circle_size / 2, label_height / 2, circle_size, Math.PI * 3 / 2, Math.PI / 2)
	context.setSourceRGBA(color.red, color.green, color.blue, 0.5)
	context.fillPreserve()
	context.restore()

	// Freeing the context before returning from the callback
	context.$dispose()
}

function to_hex ({
	color
} : {
	// A colour ranging from 0 to 1.
	color : number
}) : string {
	const hex = Math.floor(color * 255).toString(16)

	return hex.length === 1 ? '0' + hex : hex
}

// Battery widget for the bar.
const markup_percentage = '<span fgalpha="75%">%</span>'

function colour ({
	percentage
} : {
	percentage : number
}) : string {
	const red = (1 - percentage / 100)
	const green = 1
	const blue = percentage / 100

	const number = '<span foreground="#'
		+ to_hex({ color: red })
		+ to_hex({ color: green })
		+ to_hex({ color: blue } )
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
		.transform(percentage => colour({ percentage })),
	
	setup: self => self
		.connect('draw', draw_icon)
})

const battery = {
	number: widget_number
}

export default battery
