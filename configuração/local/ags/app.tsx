import app from "ags/gtk4/app"
import style from "./style.scss"
import config from "./config.json";
import { For, This, createBinding, onCleanup } from "ags"
import { Gtk } from "ags/gtk4";
import { Bar } from "./widget/bar";
import { interval, timeout, idle, createPoll } from "ags/time"
import { Corner } from "./widget/corner";
import { monitors as get_hypr_monitors } from "./services/hyprland";

export {
	config
};

function main() {
	const hypr_monitors = get_hypr_monitors();

	return (
		<For each={hypr_monitors} >
			{(monitor) => <This
				this={app}
				
			>
				<Bar monitor={monitor.id} />
				<Corner vertical="bottom" horizontal="left" monitor={monitor.id} />
				<Corner vertical="bottom" horizontal="right" monitor={monitor.id} />
				<Corner vertical="top" horizontal="right" monitor={monitor.id} />
				<Corner vertical="top" horizontal="left" monitor={monitor.id} />
			</This>}
		</For>
	)
}


app.start({
	css: style,
	icons: `${SRC}/assets/`,
	main
})