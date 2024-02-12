import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';

function dispatch (workspace: number) : void {
	Hyprland.sendMessage('dispatch workspace ' + workspace)
}

export const focusedTitle = Widget.Label({
	label: Hyprland.active.client.bind('title'),
	visible: Hyprland.active.client.bind('address')
		.transform(addr => !!addr),
});

export const Workspaces = () => Widget.EventBox({
	on_scroll_up () {
		dispatch(1)
	},

	on_scroll_down () {
		dispatch(-1)
	},

	child: Widget.Box({

		children: Array.from({ length: 10 }, (_, i) => i + 1).map(i => Widget.Button({

			attribute: i,

			label: `${i}`,

			on_clicked () {
				dispatch(i)
			}
		})),

			// remove this setup hook if you want fixed number of buttons
			// setup: self => self.hook(Hyprland, () => {
			// 	for (const btn of self.children)
			// 		btn.visible = Hyprland.workspaces.some(ws => ws.id === btn.attribute);
			// }),
	}),
})
