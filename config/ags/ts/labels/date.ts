import { EventBox, Label } from 'resource:///com/github/Aylur/ags/widget.js';
import date from '../variables/date';
import Gdk from 'node_modules/@girs/gdk-3.0/gdk-3.0';

/* Label  */
const LabelDate = EventBox({
	class_name: 'eventbox-date',
	child: (() => {
		const widget = Label({ use_markup: true, class_name: 'label-date' });

		// Change label (with Pango support) opon change of date.
		widget.hook(date, (self) => self.set_label(date.value), 'notify::value')

		return widget;
	})(),
});

LabelDate.connect('button-press-event', (_, object: Gdk.Event) => {
	print("lol")
});

export default LabelDate;
