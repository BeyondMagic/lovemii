import App from 'resource:///com/github/Aylur/ags/app.js'
import Service from "resource:///com/github/Aylur/ags/service.js"
import { Icon, Button } from "resource:///com/github/Aylur/ags/widget.js"
import data from "../../assets/data.toml"

const network = await Service.import("network")

function get_wifi_strength () {
	const max_level = 7
	const level = Math.ceil(network.wifi.strength / 100 * max_level)
	return 'network-wireless-signal-level-' + level + '-symbolic'
}

function get_main_icon (connectivity : string) : string {
	// Could not connect to network manager.
	// Probably it is not running.
	if (connectivity === 'unknown')
		return 'cloud-disabled-symbolic'

	// There are icons from level 1 to 7.
	if (network.primary === "wifi")
		return get_wifi_strength()

	return 'star-symbolic'
}

export const icon = Button({
	class_name: 'network-button',

	child: Icon({
		class_name: 'network',
		size: data.settings.icon_size,
		icon: network.bind('connectivity').transform(get_main_icon),
	}),

})

const wifi = {
	icon
}

export default wifi
