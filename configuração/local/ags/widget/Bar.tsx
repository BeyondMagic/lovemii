import { App, Astal, Gtk, Gdk } from "astal/gtk4";
import { time } from "../variables/time";
import { title } from "./components/bar/title";
import { logo } from "./components/bar/logo";
import { system_tray } from "./components/bar/system_tray";

function left_box() {
	return (
		<box
			hexpand={false}
			cssClasses={[
				"left"
			]}
		>
			{logo()}
			{title()}
		</box>
	)
}

function center_box() {
	return (
		<box
			css_classes={["center"]}
		>
			<menubutton
				css_classes={["clock"]}
			>
				<label
					use_markup
					label={time()}
				/>
				<popover>
					<Gtk.Calendar
						canTarget={false}
						canFocus={false}
					/>
				</popover>
			</menubutton>
		</box>
	)
}

function right_box() {
	return (
		<box
			spacing={6}
			halign={Gtk.Align.END}
			css_classes={[
				"right"
			]}
		>
			{system_tray()}
			{/* <NotifyStatus /> */}

			{/* <BluetoothStatus />
      <VolumeStatus />
      
      
      <Gtk.Separator />
      <PowerStatus />  */}
			{/* <WifiStatus /> */}
			{/* <BrightnessStatus /> */}
			{/* <BatteryStatus /> */}
		</box>
	)
}

function container() {
	return (
		<centerbox
			cssName="centerbox"
			cssClasses={[
				"center",
				"box"
			]}
		>
			{left_box()}
			{center_box()}
			{right_box()}
		</centerbox>
	)
}

export default function Bar(monitor_id: number) {
	const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

	return (
		<window
			name="bar"
			cssName="window"
			cssClasses={
				[
					"bar"
				]
			}
			exclusivity={Astal.Exclusivity.EXCLUSIVE}
			monitor={monitor_id}
			anchor={TOP | LEFT | RIGHT}
			application={App}
			layer={Astal.Layer.BOTTOM}
			visible
		>
			{container()}
		</window>
	);
}
