import { bind } from "astal";
import Tray from "gi://AstalTray";

export function system_tray() {
	const tray = Tray.get_default();

	return (
		<box
			css_classes={["systray"]}
			spacing={4}
		>
			{
				bind(tray, "items")
				.as(items =>
					items.map((item) => (
						<menubutton
							setup={(self) => {
								self.insert_action_group("dbusmenu", item.actionGroup);
							}}
							tooltipMarkup={bind(item, "tooltipMarkup")}
							popover={undefined}
							menuModel={bind(item, "menuModel")}
							//actionGroup={bind(item, "actionGroup").as(ag => ["dbusmenu", ag])}
						>
							<image
								gicon={bind(item, "gicon")}
							/>
						</menubutton>
					))
				)
			}
		</box>
	);
}
