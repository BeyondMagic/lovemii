import { CenterBox, Window, Label } from 'resource:///com/github/Aylur/ags/widget.js'
import { icon } from 'ts/widgets/wifi'

const container = Label({
	label: "HOOOH"
})

const wifi = Window({
	name: 'wifi',
	exclusivity: 'ignore',
	visible: false,
	child: container,
	// setup (self) {
	// 	self.
	// 	console.log(icon.translate_coordinates(icon.get_toplevel(), 0, 0))
	// }
})

export default wifi
