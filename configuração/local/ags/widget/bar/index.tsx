import app from "ags/gtk4/app"
import { Astal, Gtk, Gdk } from "ags/gtk4"

import { Icon } from "./icon"
import { Title } from "./title"
import { Date } from "./date"
import { Tray } from "./tray"
import { Workspaces } from "./workspaces"

export function Bar (gdkmonitor: Gdk.Monitor)
{
	const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

	return (
		<window
			name="bar"
			class="bar"
			exclusivity={Astal.Exclusivity.EXCLUSIVE}
			gdkmonitor={gdkmonitor}
			anchor={TOP | LEFT | RIGHT}
			application={app}
			layer={Astal.Layer.BOTTOM}
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
					<Tray />
				</box>
				
			</centerbox>
		</window>
	)
}