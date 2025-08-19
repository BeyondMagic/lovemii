import app from "ags/gtk4/app"
import style from "./style.scss"
import config from "./config.json";
// import { Corner, Vertical, Horizontal } from "./widget/corner";
import { For, This, createBinding, onCleanup } from "ags"
import { Astal, Gdk, Gtk } from "ags/gtk4";
import { Bar } from "./widget/bar";
import { interval, timeout, idle, createPoll } from "ags/time"
import GLib from "gi://GLib";
import Gio from "gi://Gio";
import GObject from "gi://GObject?version=2.0";
import { Corner } from "./widget/corner";

async function sleep(ms: number) {
	return new Promise(resolve => timeout(ms, resolve as () => void));
}

export {
	config,
	sleep
};

function main() {
	const monitors = createBinding(app, "monitors")

	return (
		<For each={monitors} cleanup={win => {
			if (win instanceof Gtk.Window)
				win.destroy()
		}}>
			{(monitor) => <This
				this={app}
			>
				<Bar gdkmonitor={monitor} />
				<Corner vertical="bottom" horizontal="left" gdkmonitor={monitor} />
				<Corner vertical="bottom" horizontal="right" gdkmonitor={monitor} />
				<Corner vertical="top" horizontal="right" gdkmonitor={monitor} />
				<Corner vertical="top" horizontal="left" gdkmonitor={monitor} />
			</This>}
		</For>
	)
}


app.start({
	css: style,
	icons: `${SRC}/assets/`,
	main
})