import Gtk from 'node_modules/@girs/gtk-3.0/gtk-3.0';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';

export function Calendar() {
	const grid = new Gtk.Grid()

	const months_years_box = (() => {
		const box = Widget.Box();

		const month_left = Widget.Button({ label: "<-" });
		const month = Widget.Button({ label: "月" });
		const month_right = Widget.Button({ label: "->" });

		const year_left = Widget.Button({ label: "<-" });
		const year = Widget.Button({ label: "年" });
		const year_right = Widget.Button({ label: "->" });

		box.add(month_left)
		box.add(month)
		box.add(month_right)

		box.add(year_left)
		box.add(year)
		box.add(year_right)

		return box;
	})()

	const days_weekdays_box = (() => {

		const weekdays = (() => {
			const box = Widget.Box({
				class_name: 'weekday',
			})

			const names = [ "日", "月", "火", "水", "木", "金", "土" ];

			for (const name of names) {
				const day = Widget.Button({
					label: name,
					on_primary_click: () => {
						print(name)
					}
				})
				box.add(day);
			}

			return box
		})();

		return weekdays
	})()

	grid.attach(months_years_box, 1, 0, 1, 1);
	grid.attach(days_weekdays_box, 1, 1, 1, 1);

	const window = Widget.Window({
		name: 'calendar',
		anchor: ['top'],
		child: grid,
	});

	window.move(100, 100);

	return window;
}
