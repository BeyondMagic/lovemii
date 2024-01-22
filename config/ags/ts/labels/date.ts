import { Label } from 'resource:///com/github/Aylur/ags/widget.js';
import date from '../variables/date';

/* Label  */
const LabelDate = (() => {
	const widget = Label({ use_markup: true, class_name: 'label-date' });

	// Change label (with Pango support) opon change of date.
	widget.hook(date, (self) => self.set_label(date.value), 'notify::value')

	return widget;
})();

export default LabelDate;
