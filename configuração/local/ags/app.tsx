import app from "ags/gtk4/app"
import style from "./style.scss"
import config from "./config.json";
import { Corner, Vertical, Horizontal } from "./widget/corner";
import { For, createBinding } from "ags"
import { Gtk } from "ags/gtk4";
import { Bar } from "./widget/bar";
import { interval, timeout, idle, createPoll } from "ags/time"

async function sleep(ms: number) {
	return new Promise(resolve => timeout(ms, resolve as () => void));
}

export {
	config,
	sleep
};


function main()
{
	const monitors = createBinding(app, "monitors")

	const verticals: Vertical[] = ["top", "bottom"]
	const horizontals: Horizontal[] = ["left", "right"]

	return (
		<For
			each={monitors}
			cleanup={win => {
				const gtk_window = win as Gtk.Window;
				gtk_window.destroy()
			}}
		>
			{(monitor, i) => {
				// Create a unique, stable window name per monitor index.
				const name = `bar-${i}`;
				return <Bar gdkmonitor={monitor} name={name} />
			}}
		</For>
	)
}

app.start({
	css: style,
	icons: `${SRC}/assets/`,
	main,
})