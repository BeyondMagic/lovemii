import app from "ags/gtk4/app"
import style from "./style.scss"
import { Bar } from "./widget/bar"
import { Corner, Vertical, Horizontal } from "./widget/corner";
import config from "./config.json";
import { Gtk } from "ags/gtk4";


export {
	config
};

app.start({
	css: style,
	main() {
		app.get_monitors().map(gdkmonitor => {
			Bar(gdkmonitor)

			for (const vertical of ['top', 'bottom'] satisfies Array<Vertical>)
				for (const horizontal of ['left', 'right'] satisfies Array<Horizontal>)
					Corner(vertical, horizontal, gdkmonitor);
		})
	},
})
