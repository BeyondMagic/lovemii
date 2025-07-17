import Widget, { Button, Box, Label, Icon } from 'resource:///com/github/Aylur/ags/widget.js';
import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';
import data from "../../../assets/data.toml"

function set_workspace (workspace: string | number) : void {
	Hyprland.messageAsync('dispatch workspace ' + workspace)
}

function set_special_workspace (workspace: string) : void {
	Hyprland.messageAsync('dispatch togglespecialworkspace ' + workspace)
}

function create_button (id : number, name : string) {
	return Button({
		class_name: 'workspace',
		hexpand_set: false,
		hexpand: false,

		setup (self) {

			let class_name = 'symbol'

			// Special workspaces.
			if (id < 0)
			{
				self.on_clicked = () => set_special_workspace(workspace)

				const [ title, workspace ] = name.split(' ')

				// If it was assigned dynamically (not upon data.toml)
				// we should use a label instead.
				if (workspace)
				{
					self.child = Icon({
						hpack: 'center',
						class_name: class_name + ' icon ' + title,
						icon: title + '-symbolic',
						size: data.settings.icon_size,
					})
					return
				}

				// Remove the 'special:' substring of the special workspace's name.
				name = name.substring(name.indexOf(':') + 1)
				class_name += ' ' + name
			} else
				// Normal workspaces.
				self.on_clicked = () => set_workspace(id)

			self.child = Label({
				class_name,
				hexpand: false,
				label: name,
			})
		}
	})
}

type ReturnButton = ReturnType<typeof Button>

const buttons = new Map<number, ReturnButton>()

// Buttons that are going to be permanent.
const permanent_buttons = new Map<number, true>()

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

function workspace_switch () : void {
	const occupied_map = new Map<number, boolean>()

	for (const workspace of Hyprland.workspaces)
		occupied_map.set(workspace.id, true)

	for (const [ id, button ] of buttons)
		button.toggleClassName('occupied', occupied_map.has(id))
}

export function remove_workspace (id : number | undefined) {
	// Some special workspace was removed.
	if (id === 0)
	{
		// Since we don't have its id, let's map all ids of the buttons
		// to the Hyprland workspaces that no longer appear.
		const special_workspaces = new Map<number, boolean>()

		for (const workspace of Hyprland.workspaces)
			if (workspace.id < 0)
				special_workspaces.set(id, true)

		for (const [ button_id ] of buttons)
			if (button_id < 0 && !special_workspaces.has(button_id))
				remove_workspace(button_id)

		// See if they are active or not.
		return workspace_switch()
	}

	if (id === undefined)
		return

	if (permanent_buttons.has(id))
		return

	const button = buttons.get(id)
	button?.destroy()
	buttons.delete(id)
}

function add_workspace (box : ReturnType<typeof Box>, id : number | undefined) {
	if (id === undefined)
		return

	// Some special workspace was added.
	if (id === 0)
	{
		// Since we don't have its id, let's try to add all of them.
		for (const w of Hyprland.workspaces)
			if (w.id < 0)
				add_workspace(box, w.id)

		// See if they are active or not.
		return workspace_switch()
	}


	// The normal workspace already exists.
	if (buttons.has(id))
		return

	// The normal workspace does not exist, so we get its content.
	const workspace = Hyprland.workspaces.find(workspace => workspace.id === id)

	if (workspace)
	{
		const button = create_button(workspace.id, workspace.name)
		buttons.set(workspace.id, button)
		box.children = box.children.concat(button)
	}
}

function window_switch () : void {
	const id = Hyprland.active.workspace.id
	for (const [i, button] of buttons)
		button.toggleClassName('active', i === id)
}

const collapsed = Widget.EventBox({
	class_name: 'workspaces-event-box',

	on_scroll_up: () => set_workspace('+1'),

	on_scroll_down: () => set_workspace('-1'),

	child: Widget.Box({
		class_name: 'workspaces',
		setup: self => self

			// When a new window is opened or closed.
			.hook(Hyprland.active.workspace, window_switch)

			// Switching to another workspace
			.hook(Hyprland, workspace_switch, 'notify::workspaces')

			// When a new workspace is added.
			.hook(Hyprland, add_workspace, 'workspace-added')

			.hook(Hyprland, (_, data : number | undefined) => remove_workspace(data), 'workspace-removed')
	}),
})

const workspaces = {
	collapsed,
	actions: {
		window_manager_setup,
		workspace_switch,
		rename_workspace,
	}
}

export default workspaces
