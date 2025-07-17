import app from "ags/gtk4/app"
import { Astal, Gtk, Gdk } from "ags/gtk4"

import { Title } from "./title"
import { Date } from "./date"
import { Tray } from "./tray"

export function Bar (gdkmonitor: Gdk.Monitor)
{
	const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

	return (
		<window
			visible
			name="bar"
			class="Bar"
			gdkmonitor={gdkmonitor}
			exclusivity={Astal.Exclusivity.EXCLUSIVE}
			anchor={TOP | LEFT | RIGHT}
			application={app}
		>
			<centerbox cssName="centerbox">
				{/* Title of current window. */}
				<Title/>

				{/* Date and time. */}
				<Date />

				{/* System trays. */}
				<Tray />
			</centerbox>
		</window>
	)
}