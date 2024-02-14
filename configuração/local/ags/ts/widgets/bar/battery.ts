import { Label, Box } from 'resource:///com/github/Aylur/ags/widget.js';
import Battery from 'resource:///com/github/Aylur/ags/service/battery.js'

// Battery widget for the bar.
const markup_percentage = '<span fgalpha="75%">%</span>'

function to_hex (c : number) : string {
	const hex = Math.floor(c).toString(16)

	return hex.length === 1 ? '0' + hex : hex
}

function colour (percentage : number) : string {
	const red = (1 - percentage / 100) * 255
	const green = percentage / 100 * 255
	const blue = 0

	return '<span foreground="#'
		+ to_hex(red)
		+ to_hex(green)
		+ to_hex(blue)
		+ '">'
		+ percentage
		+ markup_percentage
		+ '</span>'
}

function charge (charging : boolean) : string {
	return charging ? '⚡' : ''
}

const widget_number =  Box({
	class_name: 'battery',
	children: [
		Label({
			hexpand: true,
			class_name: 'number',
			use_markup: true,
			label: Battery
				.bind('percent')
				.transform(p => colour(p)),
		}),
		Label({
			class_name: 'charging',
			use_markup: true,
			label: Battery
				.bind('charging')
				.transform(charging => charge(charging))
		})
	]
})

export default {
	number: widget_number
}
