import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';

function set_workspace (workspace: string | number) : void {
	Hyprland.sendMessage('dispatch workspace ' + workspace)
}

const workspace_icons = [
	'一',
	'二',
	'三',
	'四',
	'五',
	'六',
	'七',
	'八',
	'九',
	'十',
]

function create_button (n : number) {
	return Widget.Button({

		class_name: 'workspace',

		label: workspace_icons[n],

		on_clicked () {
			set_workspace(n + 1)
		}
	})
}

const buttons = Array
	.from({ length: 10 }, (_, i) => create_button(i))

const collapsed = Widget.EventBox({
	on_scroll_up () {
		set_workspace('+1')
	},

	on_scroll_down () {
		set_workspace('-1')
	},

	child: Widget.Box({
		class_name: 'workspaces',
		children: buttons,

		setup: self => self

			// Switching to another window
			.hook(Hyprland.active.workspace, () => {
				const id = Hyprland.active.workspace.id
				for (const [i, button] of buttons.entries())
					button.toggleClassName('active', i + 1 === id)
			})

			// When a new window is opened or closed.
			.hook(Hyprland, () => {

				const workspaces = Array(10).fill(false)

				for (const workspace of Hyprland.workspaces)
					workspaces[workspace.id - 1] = true

				for (const [i, occupied] of workspaces.entries())
					buttons[i].toggleClassName('occupied', occupied)

			}, 'notify::workspaces')

	}),
})

const workspaces = {
	collapsed
}

export default workspaces
