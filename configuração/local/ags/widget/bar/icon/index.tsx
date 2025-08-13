import { createBinding, With } from "ags"
import { execAsync } from "ags/process"
import { Astal, Gtk, Gdk } from "ags/gtk4"
import { focused_client } from "../../../services/hyprland"
import { config } from "../../../app"
import { map_category } from "./map"

export function Icon() {
   return <box>
	   <With
		   value={focused_client()}
	   >
		   {client => {
			   const client_class = createBinding(client, "class");

			   return <image
				   width_request={config.corner}
				   height_request={config.corner}
				   css_classes={[
					   "icon"
				   ]}
				   icon_name={client && client_class(class_name => {
					   if (!class_name)
						   return "";

					   const category = map_category.get(class_name);

					   if (!category) {
						   printerr("No category found for class:", class_name);
						   return "unknown-status-symbolic"
					   }

					   return category;
				   })}
			   />
		   }}
	   </With>
   </box>
}