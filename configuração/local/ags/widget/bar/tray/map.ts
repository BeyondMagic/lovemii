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
    users: string | string[];
}

// Create a map of tray titles to their actions
export const map_trays = new Map<string, Tray>();

for (const tray of config.trays)
{
    // Validate users property
    if (!tray.users) {
        throw new Error(`Tray "${tray.title}" must have a "users" property`);
    }
    
    // Validate that if users is a string, only "*" is allowed as wildcard
    if (typeof tray.users === 'string' && tray.users !== '*') {
        throw new Error(`Tray "${tray.title}" has invalid user string "${tray.users}". Only "*" wildcard is allowed as string value.`);
    }
    
    // If users is an array, validate each entry
    if (Array.isArray(tray.users)) {
        for (const user of tray.users) {
            if (typeof user !== 'string') {
                throw new Error(`Tray "${tray.title}" has invalid user entry. All users must be strings.`);
            }
        }
    }

    const actions = new Set<number>(tray.remove_at);
    map_trays.set(tray.title, {
        add: tray.add,
        remove: actions,
        disabled: tray.disabled,
        users: tray.users
    });
}

/**
 * Check if the current user is allowed to use a specific tray configuration
 * @param tray_config - The tray configuration
 * @param username - The current username
 * @returns true if user is allowed, false otherwise
 */
export function is_user_allowed(tray_config: Tray, username: string): boolean {
    // If users is a string wildcard "*", allow everyone
    if (typeof tray_config.users === 'string') {
        return tray_config.users === '*';
    }
    
    // If users is an array, check if username is in the array
    if (Array.isArray(tray_config.users)) {
        return tray_config.users.includes(username);
    }
    
    return false;
}