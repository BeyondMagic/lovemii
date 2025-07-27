import { For, createBinding } from "ags"
import { AstalTray } from "../../../services/tray"
import { config } from "../../../app"
import { init, popover_position } from "./init"
import { execAsync } from "ags/process"
import { map_trays, is_user_allowed } from "./map"
import { MockTrayItem } from "./mock"
import { Gdk, Gtk } from "ags/gtk4"
import GLib from "gi://GLib"

export function Tray() {
	const tray_items = createBinding(AstalTray, "items");
	let arrow_image: Gtk.Image;

	// Create the popover with content
	const popover_content = (
		<box
			class="tray-popover-content"
			orientation={Gtk.Orientation.HORIZONTAL}
			spacing={config.tray_separator}
		>
			<For each={tray_items}>
				{(item) => (
					<menubutton
						class="tray-item"
						$={tray_self => {
							const tray_config = map_trays.get(item.title);

							if (tray_config) {
								// Convert config actions to tray actions
								const tray_actions = tray_config.add.map(action => ({
									label: action.label,
									action: () => execAsync(action.args)
								}));

								return init(tray_self, item, {
									actions: tray_actions,
									remove: tray_config.remove
								});
							}

							return init(tray_self, item);
						}}
						tooltip_markup={createBinding(item, "tooltipMarkup")}
						width_request={config.corner}
						height_request={config.corner}
					>
						<image
							css_classes={["icon"]}
							gicon={createBinding(item, "gicon")}
						/>
					</menubutton>
				)}
			</For>
		</box>
	);

	const username = GLib.get_user_name();

	// Add mock items logic in a separate reactive computation
	const mock_items = tray_items(items => {
		const active_titles = new Set(items.map(item => item.title));
		const mocks = [];
		
		for (const [title, tray_config] of map_trays.entries()) {
			// Check if the tray is not active, has disabled config, and user is allowed
			if (!active_titles.has(title) && 
				tray_config.disabled && 
				is_user_allowed(tray_config, username)) {
				mocks.push(
					<MockTrayItem 
						disabled_config={tray_config.disabled} 
						title={title} 
					/>
				);
			}
		}
		
		return mocks;
	});

	// Update popover content to include mock items
	const updated_content = (
		<box
			class="tray-popover-content"
			orientation={Gtk.Orientation.HORIZONTAL}
			spacing={config.tray_separator}
		>
			<For each={tray_items}>
				{(item) => (
					<menubutton
						class="tray-item"
						$={tray_self => {
							const tray_config = map_trays.get(item.title);

							if (tray_config) {
								// Convert config actions to tray actions
								const tray_actions = tray_config.add.map(action => ({
									label: action.label,
									action: () => execAsync(action.args)
								}));

								return init(tray_self, item, {
									actions: tray_actions,
									remove: tray_config.remove
								});
							}

							return init(tray_self, item);
						}}
						tooltip_markup={createBinding(item, "tooltipMarkup")}
						width_request={config.corner}
						height_request={config.corner}
					>
						<image
							css_classes={["icon"]}
							gicon={createBinding(item, "gicon")}
						/>
					</menubutton>
				)}
			</For>
			<For each={mock_items}>
				{(mock_item) => mock_item}
			</For>
		</box>
	);

	// Create and configure the popover
	const popover = new Gtk.Popover();
	popover.set_position(popover_position);
	popover.set_child(updated_content as any);
	
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
				css_classes={["icon"]}
				icon_name="arrow-down-symbolic"
				$={self => arrow_image = self}
			/>
		</menubutton>
	)
}