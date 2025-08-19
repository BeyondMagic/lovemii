import { Astal, Gtk, Gdk } from "ags/gtk4"
import { hyprland } from "../../../services/hyprland";
import { createBinding, createComputed, For } from "ags"
import { config } from "../../../app";
import Hyprland from "gi://AstalHyprland";
import { Workspace } from "./workspace";

export function Workspaces ( {length: length = config.workspaces} : {length?: number} )
{
	const workspaces = createBinding(hyprland(), "workspaces")
	
	   const fixed = workspaces(() =>
		   Array.from(
			   { length },
			   (_, i) => hyprland().get_workspace(i + 1) || Hyprland.Workspace.dummy(i + 1, null),
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
