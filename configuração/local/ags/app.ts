import app from "ags/gtk4/app"
import style from "./style.scss"
import config from "./config.json";
import { Bar } from "./widget/bar"
import { Corner, Vertical, Horizontal } from "./widget/corner";

export {
	config
};

app.start({
	css: style,
	icons: `${SRC}/assets/`,
	main() {
		app.get_monitors().map(gdkmonitor => {
			Bar(gdkmonitor)

			for (const vertical of ['top', 'bottom'] satisfies Array<Vertical>)
				for (const horizontal of ['left', 'right'] satisfies Array<Horizontal>)
					Corner(vertical, horizontal, gdkmonitor);
		})
	},
})
