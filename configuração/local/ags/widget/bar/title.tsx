import { execAsync } from "ags/process"
import { Astal, Gtk, Gdk } from "ags/gtk4"

export function Title ()
{
	return <button
		$type="start"
		onClicked={() => execAsync("echo hello").then(console.log)}
		hexpand
		halign={Gtk.Align.CENTER}
	>
		<label label="wow!" />
	</button>
}