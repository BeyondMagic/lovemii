import { Astal, Gtk, Gdk } from "ags/gtk4"
import { hyprland } from "../../../services/hyprland";
import { createBinding, createComputed, For } from "ags"
import { config } from "../../../app";
import Hyprland from "gi://AstalHyprland";

const focused = createBinding(hyprland, "focused_workspace")
const workspaces = createBinding(hyprland, "workspaces")

function Workspace ({ ws } : { ws: Hyprland.Workspace })
{
	const clients = createBinding(ws, "clients")
	const name = createBinding(ws, "name").as((n) => n ?? `${ws.id}`)

	const classes = createComputed([clients, focused], (cs, f) => [
		"workspace",
		cs.length > 0 ? "" : "empty",
		...(f === ws ? ["focus"] : []),
	])

	return (
		<label
			css_classes={classes}
			label={name}
			width_request={config.corner}
			height_request={config.corner}
		>
			<Gtk.GestureClick
				button={Gdk.BUTTON_PRIMARY}
				onPressed={() => {
					hyprland.message(`dispatch workspace ${ws.id}`)
				}}
			/>
		</label>
	)

}

export function Workspaces ( {length: length = config.default_workspaces.length} : {length: number} )
{
	const fixed = workspaces(() =>
		Array.from(
			{ length },
			(_, i) => hyprland.get_workspace(i + 1) || Hyprland.Workspace.dummy(i + 1, null),
		),
	)

	return <box
		class={"workspaces"}
	>
		<For each={length <= 0 ? workspaces : fixed}>
      		{(ws) => <Workspace ws={ws} />}
    	</For>
	</box>;
}
