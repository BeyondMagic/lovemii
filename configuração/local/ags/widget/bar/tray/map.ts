import { config } from "../../../app";

export type ActionBuilder = {
    label: string;
    args: string[];
}

export type Tray = {
    add: ActionBuilder[];
    remove: Set<number>;
}

// Create a map of tray titles to their actions
export const map_trays = new Map<string, Tray>();

for (const tray of config.trays)
{
    const actions = new Set<number>(tray.remove_at);
    map_trays.set(tray.title, {
        add: tray.add,
        remove: actions
    });
}