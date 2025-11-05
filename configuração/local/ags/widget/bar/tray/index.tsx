import { For, createBinding, onCleanup } from "ags"
import AstalTray from "gi://AstalTray"
import { config } from "../../../app"
import { Gtk } from "ags/gtk4"
import GLib from "gi://GLib"
import Gio from "gi://Gio"

const ZERO_WIDTH_SPACE = "\u200B"

function make_unique_label(label: string, counts: Map<string, number>) {
	const count = counts.get(label) ?? 0
	counts.set(label, count + 1)
	if (count === 0)
		return label
	return `${label}${ZERO_WIDTH_SPACE.repeat(count)}`
}

function clone_menu_model(model: Gio.MenuModel | null, counts = new Map<string, number>()): Gio.Menu {
	const menu = new Gio.Menu()
	if (!model)
		return menu

	const items = model.get_n_items()
	for (let index = 0; index < items; index++) {
		const section_link = model.get_item_link(index, "section")
		if (section_link) {
			const section_menu = clone_menu_model(section_link, counts)
			const section_label_variant = model.get_item_attribute_value(index, "label", null)
			const section_label = section_label_variant ? section_label_variant.deepUnpack() as string : null
			const unique_section_label = section_label ? make_unique_label(section_label, counts) : null
			menu.append_section(unique_section_label, section_menu)
			continue
		}

		const menu_item = Gio.MenuItem.new_from_model(model, index)
		const submenu_link = model.get_item_link(index, "submenu")

		if (submenu_link) {
			const label_variant = model.get_item_attribute_value(index, "label", null)
			const label = label_variant ? label_variant.deepUnpack() as string : null
			if (label) {
				const unique_label = make_unique_label(label, counts)
				menu_item.set_attribute_value("label", GLib.Variant.new_string(unique_label))
			}
			menu_item.set_submenu(clone_menu_model(submenu_link, counts))
		}

		menu.append_item(menu_item)
	}

	return menu
}

export function Tray() {


	const tray = AstalTray.get_default()
	const items = createBinding(tray, "items")

	const setup_item = (btn: Gtk.MenuButton, item: AstalTray.TrayItem) => {
		const update_menu_model = () => {
			try {
				btn.menuModel = clone_menu_model(item.menuModel)
			} catch (error) {
				print(`Failed to clone menu model for tray item: ${error}`)
			}
		}

		update_menu_model()

		btn.insert_action_group("dbusmenu", item.actionGroup)

		// update on action-group changes
		const conn = item.connect("notify::action-group", () => {
			btn.insert_action_group("dbusmenu", item.actionGroup)
		})
		const menu_conn = item.connect("notify::menu-model", update_menu_model)

		// ensure we cleanup when this menubutton unmounts
		onCleanup(() => {
			try { item.disconnect(conn) } catch { }
			try { item.disconnect(menu_conn) } catch { }
			try { btn.insert_action_group("dbusmenu", null) } catch { }
			try { (btn as any).set_menu_model?.(null) ?? (btn.menuModel = null as any) } catch { }
		})
	}

	const trays = (
		<box
			class={'items'}
			spacing={4}
		>
			<For each={items}>
				{(item) => (
					<menubutton
						$={(self) => setup_item(self, item)}
					>
						<image gicon={createBinding(item, "gicon")} />
					</menubutton>
				)}
			</For>
		</box>
	)

	// Create and configure the popover
	const popover = new Gtk.Popover();
	popover.set_position(Gtk.PositionType.BOTTOM);
	popover.set_child(trays as any);

	let arrow_image: Gtk.Image;

	// Connect to popover visibility changes
	popover.connect("notify::visible", () => {
		if (arrow_image) {
			arrow_image.set_from_icon_name(
				popover.visible ? "arrow-up-symbolic" : "arrow-down-symbolic"
			);
		}
	});

	return (
		<menubutton
			class="tray-button"
			width_request={config.corner}
			height_request={config.corner}
			$={self => self.set_popover(popover)}
		>
			<image
				class="icon"
				icon_name="arrow-down-symbolic"
				$={self => arrow_image = self}
			/>
		</menubutton>
	)
}