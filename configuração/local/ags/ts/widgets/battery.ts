import { Box, Label } from 'resource:///com/github/Aylur/ags/widget.js';
import Battery from 'resource:///com/github/Aylur/ags/service/battery.js'

type Color = {
	red : number
	green : number
	blue : number
}

function gradient ({
	percentage
} : {
	percentage : number
}) : Color {
	const range = percentage / 100

	return {
		red: 1,
		green: 1,
		blue: 1,
	}
}

function draw ({
	context
} : {
	context : any
}) : void {

}

// Battery widget for the bar.
const markup_percentage = '<span fgalpha="75%">%</span>'

function format_text ({
	percentage
} : {
	percentage : number
}) : string {
	const number =
		+ percentage
		+ markup_percentage

	return number
}

const label = Label({
	class_name: 'label',
	visible: Battery.bind('available'),
	width_chars: 4,
	use_markup: true,
	label: Battery
		.bind('percent')
		.transform(percentage => format_text({ percentage })),
	//setup: self => self
	//	.connect('draw', draw_icon)
})

const box = Box({

	children: [
		label
	],

	class_name: Battery.
		bind('charging')
		.transform(charging => {
			return charging ? 'charging battery' : 'battery'
		}),
	
})

const battery = {
	label,
	box,
}

export default battery
