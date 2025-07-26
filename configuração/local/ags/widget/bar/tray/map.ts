import { config } from "../../../app";

export type ActionBuilder = {
    label: string;
    args: string[];
}

export type DisabledConfig = {
    icon_name: string;
    tooltip: string;
    buttons: ActionBuilder[];
}

export type Tray = {
    add: ActionBuilder[];
    remove: Set<number>;
    disabled?: DisabledConfig;
}

// Create a map of tray titles to their actions
export const map_trays = new Map<string, Tray>();

for (const tray of config.trays)
{
    const actions = new Set<number>(tray.remove_at);
    map_trays.set(tray.title, {
        add: tray.add,
        remove: actions,
        disabled: tray.disabled
    });
}