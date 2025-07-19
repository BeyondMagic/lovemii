import { createBinding, With } from "ags"
import { execAsync } from "ags/process"
import { Astal, Gtk, Gdk } from "ags/gtk4"
import { config } from "../../../app"
import { Label } from "./label"

export function Title() {
	return <button
		onClicked={() => execAsync("echo hello").then(console.log)}
	>
		<Label />
	</button>
}