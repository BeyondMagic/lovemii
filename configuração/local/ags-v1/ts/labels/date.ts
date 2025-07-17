import { EventBox, Label } from 'resource:///com/github/Aylur/ags/widget.js';
import date from '../variables/date';

const label_date = EventBox({
	class_name: 'eventbox-date',

	child: Label({
		use_markup: true,
		class_name: 'label-date',
	})

	// Change label (with Pango support) opon change of date.
	.hook(
		date,
		self => self.set_label(date.value),
		'notify::value'
	)
});

// LabelDate.connect('button-press-event', (_, object: Gdk.Event) => {
// 	print("lol")
// });

export default label_date
