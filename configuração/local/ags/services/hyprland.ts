import Hyprland from "gi://AstalHyprland";
import { createBinding } from "ags"

const service = Hyprland.get_default();

const focused_client = createBinding(
	service,
	"focused_client"
);

export {
	focused_client,
	service as hyprland,
}