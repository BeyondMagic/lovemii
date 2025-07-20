import { For, createBinding } from "ags"
import { AstalTray } from "../../../services/tray"
import { config } from "../../../app"
import { init } from "./init"
import { execAsync } from "ags/process"
import { map_trays } from "./map"

export function Tray ()
{
    const tray_items = createBinding(AstalTray, "items");

    return (
        <box class="trays">
            <For each={tray_items}>
				{(item) => {					
                    return <menubutton
						$={self => {
							const tray_config = map_trays.get(item.title);

							if (tray_config)
							{
								// Convert config actions to tray actions
								const tray_actions = tray_config.add.map(action => ({
									label: action.label,
									action: () => execAsync(action.args)
								}));

								return init(self, item, {
									actions: tray_actions,
									remove: tray_config.remove
								});
							}

							return init(self, item);
						}}
						tooltip_markup={createBinding(item, "tooltipMarkup")}
						width_request={config.corner}
						height_request={config.corner}
					>
						<image
							css_classes={[
								"icon"
							]}
							gicon={createBinding(item, "gicon")}
						/>
                    </menubutton>
				}}
            </For>
        </box>
    )
}