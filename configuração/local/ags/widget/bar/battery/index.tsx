import { Astal, Gtk, Gdk } from "ags/gtk4"
import { config } from "../../../app"
import { createBinding } from "ags"

import Service from "gi://AstalBattery"

export function Battery ()
{
	const service = Service.get_default()
	
	const percentage = createBinding(service, "percentage");

	const icon = (
		service.is_battery && <label
			css_classes={["battery"]}
			label={percentage(v => `${Math.trunc(v * 100)}%`)}
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