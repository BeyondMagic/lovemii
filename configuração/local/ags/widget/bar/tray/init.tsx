import { onCleanup } from "ags"
import service from "gi://AstalTray"
import { Gtk } from "ags/gtk4"
import Gio from "gi://Gio"

const custom = {
    group: "custom",
}

export const popover_position = Gtk.PositionType.BOTTOM;

function extract_menumodel (item: service.TrayItem, remove?: Set<number>) : Gio.Menu | null
{
    if (!item.menu_model)
		return null;

    const menu = new Gio.Menu();
    const n_items = item.menu_model.get_n_items();

    for (let i = 0; i < n_items; i++)
	{
		// Skip this item if it's in the remove set
		if (remove && remove.has(i)) {
			continue;
		}

        const label = item.menu_model.get_item_attribute_value(i, Gio.MENU_ATTRIBUTE_LABEL, null);
        const action = item.menu_model.get_item_attribute_value(i, Gio.MENU_ATTRIBUTE_ACTION, null);
        const target = item.menu_model.get_item_attribute_value(i, Gio.MENU_ATTRIBUTE_TARGET, null);

        const label_str = label ? label.get_string()[0] : "";

        if (label && action) {
            const action_str = action.get_string()[0];

            if (target) {
                menu.append(label_str, action_str);
                // Note: target handling would need more complex logic
            } else {
                menu.append(label_str, action_str);
            }
        } else {
            // Handle submenu or section
            const submenu = item.menu_model.get_item_link(i, Gio.MENU_LINK_SUBMENU);
            const section = item.menu_model.get_item_link(i, Gio.MENU_LINK_SECTION);

            if (submenu) {
                const submenu_label = label ? label.get_string()[0] : null;
                menu.append_submenu(submenu_label, submenu);
            } else if (section) {
                const section_label = label ? label.get_string()[0] : null;
                menu.append_section(section_label, section);
            }
        }
    }

    return menu;
}

// Create a custom menu model that combines the original menu with our custom item
function create_combined_menu (item: service.TrayItem, tray_actions: TrayAction[], remove_actions?: Set<number>)
{
    const menu = new Gio.Menu()

    // Add our custom menu items first
    for (const tray_action of tray_actions) {
        menu.append(tray_action.label, `${custom.group}.${tray_action.label}`)
    }

    // Add the original menu as a section if it exists and has items
    if (item.menu_model && item.menu_model.get_n_items() > 0)
	{
        // Add a separator by creating an empty section
        const separator = new Gio.Menu()
        menu.append_section(null, separator)

        if (remove_actions && remove_actions.size > 0)
		{
			const modified_menu = extract_menumodel(item, remove_actions);
			if (modified_menu)
            	menu.append_section(null, modified_menu);
        } else {
            // Add the original menu model as a section (unchanged)
            menu.append_section(null, item.menu_model)
        }
    }

    return menu
}

type TrayAction = {
	label: string;
	action: () => void;
};

type TrayConfig = {
	actions: TrayAction[];
	remove?: Set<number>;
};

function create_custom_action_group(tray_actions: TrayAction[]): Gio.SimpleActionGroup {
	const action_group = new Gio.SimpleActionGroup();
	
	for (const tray_action of tray_actions) {
		const custom_action = new Gio.SimpleAction({ name: tray_action.label });
		custom_action.connect("activate", tray_action.action);
		action_group.add_action(custom_action);
	}
	
	return action_group;
}

function cleanup_action_group(action_group: Gio.SimpleActionGroup, action_names: string[]) {
	for (const name of action_names) {
		action_group.remove_action(name);
	}
}

export function init (btn: Gtk.MenuButton, item: service.TrayItem, tray_config?: TrayConfig)
{
	// Clean up any existing action groups first
	btn.insert_action_group("dbusmenu", null)
	btn.insert_action_group("custom", null)
	btn.set_menu_model(null)

	const tray_actions = tray_config?.actions || [];
	const remove_actions = tray_config?.remove;
	const custom_labels = tray_actions.map(action => action.label);

	// Create and setup custom action group
	let custom_action_group: Gio.SimpleActionGroup | null = null;
	if (tray_actions.length > 0) {
		custom_action_group = create_custom_action_group(tray_actions);
		btn.insert_action_group(custom.group, custom_action_group);
	}

	// Insert both action groups
	btn.insert_action_group("dbusmenu", item.action_group)

	// Set the combined menu
	btn.set_menu_model(create_combined_menu(item, tray_actions, remove_actions))

	// Set the popover position to LEFT
	const popover = btn.get_popover();
	if (popover) {
		popover.set_position(popover_position);
	}

	/*const conns = [
		item.connect(
			"notify::action-group",
			() => {
				// Check if popover is currently visible before updating
				const popover = btn.get_popover();
				const was_visible = popover ? popover.get_visible() : false;

				// print(`Popover was ${was_visible ? 'visible' : 'hidden'}`);
				
				btn.insert_action_group("dbusmenu", item.action_group)
				btn.set_menu_model(create_combined_menu(item, tray_actions, remove_actions))
				
				// Get a fresh popover reference after updating the menu model
				   const new_popover = btn.get_popover();
				   if (new_popover) {
					   new_popover.set_position(popover_position);
					   // Only popup if it was visible and is mapped/realized
					   if (was_visible && typeof new_popover.get_mapped === 'function' && new_popover.get_mapped()) {
						   new_popover.popup();
					   }
				   }
			}
		),
		item.connect(
			"notify::menu-model",
			() => {
				// Check if popover is currently visible before updating
				const popover = btn.get_popover();
				const was_visible = popover ? popover.get_visible() : false;

				// console.debug(`Popover was ${was_visible ? 'visible' : 'hidden'}`);

				btn.set_menu_model(create_combined_menu(item, tray_actions, remove_actions))
				
				   // Get a fresh popover reference after updating the menu model
				   const new_popover = btn.get_popover();
				   if (new_popover) {
					   new_popover.set_position(popover_position);
					   // Only popup if it was visible and is mapped/realized
					   if (was_visible && typeof new_popover.get_mapped === 'function' && new_popover.get_mapped()) {
						   new_popover.popup();
					   }
				   }
			}
		)
	]*/

	onCleanup(() => {
		// Disconnect all signal connections
		conns.map((id) => item.disconnect(id));
		
		// Clean up action groups and menu model
		btn.insert_action_group("dbusmenu", null)
		btn.insert_action_group("custom", null)
		btn.set_menu_model(null)
		
		// Clean up custom action group if it exists
		if (custom_action_group && custom_labels.length > 0) {
			cleanup_action_group(custom_action_group, custom_labels);
		}
	});

}