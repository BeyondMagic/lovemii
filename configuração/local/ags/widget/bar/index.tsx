import app from "ags/gtk4/app"
import { Astal, Gtk, Gdk } from "ags/gtk4"

import { Icon } from "./icon"
import { Title } from "./title"
import { Date } from "./date"
import { Tray } from "./tray"
import { Workspaces } from "./workspaces"
import { Battery} from "./battery"
import { config } from "../../app"

export function Bar ({gdkmonitor, name = "bar"}: {gdkmonitor: Gdk.Monitor, name?: string})
{
	const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

	return (
		<window
			name={name}
			class="bar"
			exclusivity={Astal.Exclusivity.EXCLUSIVE}
			gdkmonitor={gdkmonitor}
			anchor={TOP | LEFT | RIGHT}
			application={app}
			layer={Astal.Layer.BACKGROUND}
			visible
		>
			<centerbox cssName="centerbox">
				{/* Information of current window. */}
				<box
					$type="start"
				>
					<Icon />
					<Title />
				</box>

				{/* Date and time. */}
				<Date />

				{/* Workspaces and system trays. */}
				<box
					$type="end"
				>
					
					<Workspaces />
					{/* To-do: The height is 100%, so commenting this for now. */}
					{/* <Gtk.Separator
						orientation={Gtk.Orientation.VERTICAL}
						height_request={5}
						visible={true}
					/> */}
					<Tray />
					
					<Battery />
				</box>
				
			</centerbox>
		</window>
	)
}