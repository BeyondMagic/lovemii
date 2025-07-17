import { execAsync } from "ags/process"
import { Astal, Gtk, Gdk } from "ags/gtk4"
import { createPoll } from "ags/time"

export function Date ()
{
	const time = createPoll("", 1000, "date")

	return <menubutton $type="end" hexpand halign={Gtk.Align.CENTER}>
		<label label={time} />
		<popover>
			<Gtk.Calendar />
		</popover>
	</menubutton>
}