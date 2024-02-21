import Widget, { Button, Box } from 'resource:///com/github/Aylur/ags/widget.js';
import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';
import data from "../../../assets/data.toml"

function set_workspace (workspace: string | number) : void {
	Hyprland.messageAsync('dispatch workspace ' + workspace)
}

function create_button (id : number, name : string) {
	return Button({
		class_name: 'workspace',

		label: name,

		on_clicked: () => set_workspace(id)
	})
}

type ReturnButton = ReturnType<typeof Button>

const buttons = new Map<number, ReturnButton>()

// Buttons that are going to be permanent.
const permanent_buttons = new Map<number, true>()
let hyprland_loaded = false

function window_manager_setup (box: ReturnType<typeof Box>) : void {
	
	const workspaces = new Map<number, string>()
	for (const { id, name } of data.settings.workspaces)
	{
		permanent_buttons.set(id, true)
		workspaces.set(id, name)
	}

	for (const { id, name } of Hyprland.workspaces)
		if (!workspaces.get(id))
			workspaces.set(id, name)

	// Create, add, and set default buttons (will not be removed).
	const default_buttons : Array<ReturnType<typeof Button>> = []
	for (const [ id, name ] of workspaces)
	{
		const button = create_button(id, name)
		default_buttons.push(button)

		// Also set in the map so we can reference later.
		buttons.set(id, button)
	}
	box.children = default_buttons
}

function rename_workspace (data : string) {
	const comma = data.indexOf(',')

	const workspace = {
		id: parseInt(data.substring(0, comma)),
		name: data.substring(comma + 1)
	}

	const button = buttons.get(workspace.id)

	if (!button)
		return

	button.label = workspace.name
}

function remove_workspace (data : string | undefined) {
	if (!data)
		return

	const id = parseInt(data)

	if (permanent_buttons.has(id))
		return

	const button = buttons.get(id)
	button?.destroy()
	buttons.delete(id)
}

function add_workspace (box : ReturnType<typeof Box>, data : string | undefined) {
	if (!data)
		return

	const id = parseInt(data)

	if (buttons.has(id))
		return

	for (const workspace of Hyprland.workspaces)
		if (workspace.id === id)
		{
			const button = create_button(id, workspace.name)
			buttons.set(id, button)
			box.children = box.children.concat(button)
			return
		}
}

function event_handler (box : ReturnType<typeof Box>, event : string, data : string) {
	// When Hyprland is fully loaded.
	if (!hyprland_loaded)
	{
		hyprland_loaded = true
		window_manager_setup(box)
	}

	// When a new workspace is renamed, set it in the bar.
	if (event === 'renameworkspace')
		rename_workspace(data)
	if (!hyprland_loaded)
	{
		hyprland_loaded = true
		window_manager_setup(box)
	}

	// When a new workspace is renamed, set it in the bar.
	if (event === 'renameworkspace')
		rename_workspace(data)
}

function workspace_switch () : void {
	const occupied_map = new Map<number, boolean>()

	for (const workspace of Hyprland.workspaces)
		occupied_map.set(workspace.id, true)

	for (const [ id, button ] of buttons)
		button.toggleClassName('occupied', occupied_map.has(id))
}

function window_switch () : void {
	const id = Hyprland.active.workspace.id
	for (const [i, button] of buttons)
		button.toggleClassName('active', i === id)
}

const collapsed = Widget.EventBox({
	on_scroll_up: () => set_workspace('+1'),

	on_scroll_down: () => set_workspace('-1'),

	child: Widget.Box({
		class_name: 'workspaces',
		setup: self => self

			// Switching to another window
			.hook(Hyprland.active.workspace, window_switch)

			// When a new window is opened or closed.
			.hook(Hyprland, workspace_switch, 'notify::workspaces')

			.hook(Hyprland, event_handler, 'event')

			// When a new workspace is added.
			.hook(Hyprland, add_workspace, 'workspace-added')

			.hook(Hyprland, (_, data : string | undefined) => remove_workspace(data), 'workspace-removed')
	}),
})

const workspaces = {
	collapsed
}

export default workspaces
