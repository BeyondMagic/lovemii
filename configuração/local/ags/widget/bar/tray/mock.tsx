import { execAsync } from "ags/process";
import { config } from "../../../app";
import { Gtk } from "ags/gtk4";
import Gio from "gi://Gio";
import { DisabledConfig } from "./map";

// type MockTrayAction = {
//     label: string;
//     action: () => void;
// };

function sanitize_action_name(name: string): string {
    return name
        .toLowerCase()
        .replace(/[^a-z0-9]/g, '_')  // Replace any non-alphanumeric with underscore
        .replace(/_+/g, '_')         // Replace multiple underscores with single
        .replace(/^_|_$/g, '');      // Remove leading/trailing underscores
}

function create_mock_menu(disabled_config: DisabledConfig): Gio.Menu {
    const menu = new Gio.Menu();
    
    for (const button of disabled_config.buttons) {
        const action_name = sanitize_action_name(button.label);
        menu.append(button.label, `mock.${action_name}`);
    }
    
    return menu;
}

function create_mock_action_group(disabled_config: DisabledConfig): Gio.SimpleActionGroup {
    const action_group = new Gio.SimpleActionGroup();
    
    for (const button of disabled_config.buttons) {
        const action_name = sanitize_action_name(button.label);
        const action = new Gio.SimpleAction({ name: action_name });
        action.connect("activate", () => execAsync(button.args));
        action_group.add_action(action);
    }
    
    return action_group;
}

export function MockTrayItem({ disabled_config, title }: { disabled_config: DisabledConfig, title: string }) {
    return (
        <menubutton
            class="tray-item mock-tray-item"
            tooltip_text={disabled_config.tooltip}
            width_request={config.corner}
            height_request={config.corner}
            $={self => {
                // Create and set up the mock action group
                const action_group = create_mock_action_group(disabled_config);
                self.insert_action_group("mock", action_group);
                
                // Create and set the menu model
                const menu = create_mock_menu(disabled_config);
                self.set_menu_model(menu);
                
                // Set popover position
                const popover = self.get_popover();
                if (popover) {
                    popover.set_position(Gtk.PositionType.BOTTOM);
                }
            }}
        >
            <image
                css_classes={["icon", "mock-icon"]}
                icon_name={disabled_config.icon_name}
            />
        </menubutton>
    );
}
