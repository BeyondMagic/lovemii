import { execAsync } from "ags/process"
import { Astal, Gtk, Gdk } from "ags/gtk4"
import { text } from "./text"

export function Date ()
{
	return <menubutton $type="end" hexpand halign={Gtk.Align.CENTER}>
		<label use_markup label={text()} />
		<popover>
			<Gtk.Calendar />
		</popover>
	</menubutton>
}