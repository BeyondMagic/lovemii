import { Astal, Gtk, Gdk } from "ags/gtk4"
import { config } from "../../../app"
import { createBinding } from "ags"
import { get_color_at_percentage } from "./color"

import Service from "gi://AstalBattery"

export function Battery ()
{
	const service = Service.get_default()
	
	const percentage = createBinding(service, "percentage");

	// Define the battery color gradient: dark blue (low) -> light blue (medium) -> pink (high)
	const batteryColors = [
		'#101657ff', // Dark Blue (0%)
		'#337eb5ff', // Light Blue (50%)
		'#d36799ff'  // Pink (100%)
	];

	const icon = (
		service.is_battery && <label
			css_classes={["battery"]}
			use_markup
			label={percentage(v => {
				const percent = Math.trunc(v * 100);
				const color = get_color_at_percentage(batteryColors, percent);
				return `<span color="${color}">${percent}%</span>`;
			})}
		/> || <image
			width_request={config.corner}
			height_request={config.corner}
			css_classes={["icon"]}
			icon_name='menu-navigation-open'
		/>
	)

	return <box
		css_classes={[
			"menu"
		]}
	>
		{icon}
	</box>
}