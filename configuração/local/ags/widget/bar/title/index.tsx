import { createBinding, With } from "ags"
import { execAsync } from "ags/process"
import { Astal, Gtk, Gdk } from "ags/gtk4"
import { hyprland } from "../../../services/hyprland"
import { config } from "../../../app"
import { Label } from "./label"

export function Title() {
	return <button
		$type="start"
		onClicked={() => execAsync("echo hello").then(console.log)}
		hexpand
		halign={Gtk.Align.CENTER}
	>
		<Label />
	</button>
}