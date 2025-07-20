import Tray from "gi://AstalTray"

const service = Tray.get_default();

export {
	service as AstalTray,
}