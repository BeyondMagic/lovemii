import { For, createBinding, onCleanup } from "ags"
import { astal_tray } from "../../../services/tray"
import AstalTray from "gi://AstalTray"
import { config } from "../../../app"
import { execAsync } from "ags/process"
import { map_trays, is_user_allowed } from "./map"
import { MockTrayItem } from "./mock"
import { Gdk, Gtk } from "ags/gtk4"
import GLib from "gi://GLib"

export function Tray() {


	const tray = AstalTray.get_default()
	const items = createBinding(tray, "items")

	const setup_item = (btn: Gtk.MenuButton, item: AstalTray.TrayItem) => {
		// bind initial state
		btn.menuModel = item.menuModel
		btn.insert_action_group("dbusmenu", item.actionGroup)

		// update on action-group changes
		const conn = item.connect("notify::action-group", () => {
			btn.insert_action_group("dbusmenu", item.actionGroup)
		})

		// ensure we cleanup when this menubutton unmounts
		onCleanup(() => {
			try { item.disconnect(conn) } catch {}
			try { btn.insert_action_group("dbusmenu", null) } catch {}
			try { (btn as any).set_menu_model?.(null) ?? (btn.menuModel = null as any) } catch {}
		})
	}

	return (
		<box>
			<For each={items}>
				{(item) => (
					<menubutton $={(self) => setup_item(self, item)}>
						<image gicon={createBinding(item, "gicon")} />
					</menubutton>
				)}
			</For>
		</box>
	)
}