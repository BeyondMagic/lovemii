import app from "ags/gtk4/app"
import { Gtk } from "ags/gtk4";
import { For, This } from "ags"
import GLib from "gi://GLib";

import style from "./style.scss"
import config from "./config.json";

import { monitors as get_hypr_monitors } from "./services/hyprland";

import { Bar } from "./widget/bar";
import { Corner } from "./widget/corner";
import { Launcher } from "./widget/launcher";

export {
	config
};

let app_launcher: Gtk.Window;

function main()
{
	const hypr_monitors = get_hypr_monitors();

	app_launcher = Launcher() as Gtk.Window;
	app.add_window(app_launcher);

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

function request_handler(request: string, res: (response: any) => void)
{
	const [, argv] = GLib.shell_parse_argv(request)

	if (!argv)
		return res("argv parse error")

	switch (argv[0])
	{
		case "toggle":
			app_launcher.visible = !app_launcher.visible
			return res("ok")
		default:
			return res("unknown command")
	}
}


app.start({
	css: style,
	icons: `${SRC}/assets/`,
	requestHandler: request_handler,
	main
})