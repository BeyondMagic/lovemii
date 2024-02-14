import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';

function set_workspace (workspace: number) : void {
	Hyprland.sendMessage('dispatch workspace ' + workspace)
}

const max_string_n = 100

export const focused_title = Widget.Label({
	label: Hyprland
		.active
		.client
		.bind('title')
		.transform(title => title.substring(0, max_string_n)),

	visible: Hyprland
		.active
		.client
		.bind('address')
		.transform(addr => !!addr),
});

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

	const widget = Widget.Button({

		class_name: 'workspace',
		attribute: n,
		label: workspace_icons[n],

		on_clicked () {
			set_workspace(n)
		}
	})

	return widget
}


export const workspaces = Widget.EventBox({
	on_scroll_up () {
		set_workspace(1)
	},

	on_scroll_down () {
		set_workspace(-1)
	},

	child: Widget.Box({
		class_name: 'workspaces',
		children: Array
			.from({ length: 10 }, (_, i) => i)
			.map(i => create_button(i)),

		// remove this setup hook if you want fixed number of buttons
		// setup: self => self.hook(Hyprland, () => {
		// 	for (const btn of self.children)
		// 		btn.visible = Hyprland.workspaces.some(ws => ws.id === btn.attribute);
		// }),
	}),
})
