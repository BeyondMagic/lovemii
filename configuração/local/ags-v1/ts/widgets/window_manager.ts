import window from './window_manager/window'
import workspaces from './window_manager/workspaces'
import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';

let hyprland_loaded = false

function event_handler (event : string, data : string) {
	// When Hyprland is fully loaded.
	if (!hyprland_loaded)
	{
		hyprland_loaded = true
		workspaces.actions.window_manager_setup(workspaces.collapsed.child)
		workspaces.actions.workspace_switch()
		window.actions.update_title_class()
	}

	// When a new workspace is renamed, set it in the bar.
	if (event === 'renameworkspace')
		workspaces.actions.rename_workspace(data)
}

Hyprland.connect('event', (_, ipc, data) => event_handler(ipc, data))


const window_manager = {
	workspaces,
	window
}

export default window_manager
