import { For, createBinding } from "ags"
import { astal_tray } from "../../../services/tray"
import AstalTray from "gi://AstalTray"
import { config } from "../../../app"
import { init, popover_position } from "./init"
import { execAsync } from "ags/process"
import { map_trays, is_user_allowed } from "./map"
import { MockTrayItem } from "./mock"
import { Gdk, Gtk } from "ags/gtk4"
import GLib from "gi://GLib"

export function Tray() {


	const tray = AstalTray.get_default()
	const items = createBinding(tray, "items")

	const init = (btn: Gtk.MenuButton, item: AstalTray.TrayItem) => {
		btn.menuModel = item.menuModel
		btn.insert_action_group("dbusmenu", item.actionGroup)
		item.connect("notify::action-group", () => {
			btn.insert_action_group("dbusmenu", item.actionGroup)
		})
	}

	return (
		<box>
			<For each={items}>
				{(item) => (
					<menubutton $={(self) => init(self, item)}>
						<image gicon={createBinding(item, "gicon")} />
					</menubutton>
				)}
			</For>
		</box>
	)
}