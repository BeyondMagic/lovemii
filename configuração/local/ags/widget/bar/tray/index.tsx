import { For, createBinding } from "ags"
import { AstalTray } from "../../../services/tray"
import { config } from "../../../app"
import { init } from "./init"
import { execAsync } from "ags/process"
import { map_trays } from "./map"
import { Gtk } from "ags/gtk4"

export function Tray() {
	const tray_items = createBinding(AstalTray, "items");

	// Create the popover with content
	const popover_content = (
		<box
			class="tray-popover-content"
			orientation={Gtk.Orientation.HORIZONTAL}
			spacing={config.tray_separator}
		>
			<For each={tray_items}>
				{(item) => {
					return (
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
					);
				}}
			</For>
		</box>
	);

	// Create and configure the popover
	const popover = new Gtk.Popover();
	popover.set_position(Gtk.PositionType.BOTTOM);
	popover.set_child(popover_content as any);

	return (
		<menubutton
			class="tray-button"
			width_request={config.corner}
			height_request={config.corner}
			$={self => self.set_popover(popover)}
		>
			<image
				css_classes={["icon"]}
				icon_name="applications-system-symbolic"
			/>
		</menubutton>
	)
}