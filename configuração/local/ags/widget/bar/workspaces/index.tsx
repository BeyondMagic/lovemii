import { hyprland } from "../../../services/hyprland";
import { createBinding, For } from "ags"
import { config } from "../../../app";
import Hyprland from "gi://AstalHyprland";
import { Workspace } from "./workspace";

const workspaceLabels = new Map(
	config.workspaces.labels.map(({ id, label }) => [id, label] as const),
);

export function Workspaces ( {length}: {length?: number} )
{
	const total = length ?? config.workspaces.total;
	const workspaces = createBinding(hyprland(), "workspaces")

	const display = workspaces((existing) => {
		const raw: Hyprland.Workspace[] = Array.isArray(existing) ? existing : [];
		const actual = raw.filter((ws) => ws.id >= 0);
		// printerr("[workspaces] filtered special workspaces:", raw.filter((ws) => ws.id < 0).map((ws) => ws.id));
		// printerr("[workspaces] actual ids:", actual.map((ws) => ws.id));
		if (total <= 0)
			return actual.map((ws) => ({ ws, fallbackLabel: workspaceLabels.get(ws.id) }));

		const byId = new Map(actual.map((ws) => [ws.id, ws] as const));
		const seen = new Set<number>();
		const result: { ws: Hyprland.Workspace; fallbackLabel?: string }[] = [];

		for (let id = 1; id <= total; id++) {
			const ws = byId.get(id) ?? Hyprland.Workspace.dummy(id, null);
			// printerr(`[workspaces] fallback dummy for id ${id}`, workspaceLabels.get(id));
			result.push({ ws, fallbackLabel: workspaceLabels.get(id) });
			seen.add(id);
		}

		for (const ws of actual) {
			if (!seen.has(ws.id))
			{
				// printerr(`[workspaces] extra workspace ${ws.id} label`, workspaceLabels.get(ws.id));
				result.push({ ws, fallbackLabel: workspaceLabels.get(ws.id) });
			}
		}

		// printerr("[workspaces] display slots:", result.map(({ ws, fallbackLabel }) => ({ id: ws.id, name: ws.name, fallbackLabel })));
		return result;
	})

	return <box class={"workspaces"}>
		<For each={display}>
			{({ ws, fallbackLabel }) => <Workspace ws={ws} fallbackLabel={fallbackLabel} />}
		</For>
	</box>;
}
