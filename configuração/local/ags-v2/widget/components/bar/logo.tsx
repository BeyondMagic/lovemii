import { bind } from "astal";
import { hyprland } from "../../hyprland";
import config from "../../../config.json";

// Make a map for each program class name to its respective kind.
// A kind is the name for a default desktop software,
// e.j: terminal, firefox, email, ...
const class_to_kind = new Map<string, string>();

// Evaluate the map.
for (const item of config.kinds)
	for (const name of item.find)
		class_to_kind.set(name, item.replace);

export function logo() {
	return (
		<image
			icon_name={
				bind(hyprland, "focused_client")
					.as(client => {
						if (!client)
							return "";

						const class_name = client.get_class();
						const kind = class_to_kind.get(class_name);

						if (!kind)
							return "unknown-status-symbolic";

						return kind;
					}
					)}
			css_classes={[
				"logo"
			]}
			width_request={config.corner}
			height_request={config.corner}
		/>
	)
}