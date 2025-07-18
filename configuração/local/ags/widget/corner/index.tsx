import app from "ags/gtk4/app"
import { Astal, Gtk, Gdk } from "ags/gtk4";
import { Horizontal, Vertical, drawing_area } from "./math";

export function Corner (vertical: Vertical, horizontal: Horizontal, gdkmonitor: Gdk.Monitor)
{
    const vertical_anchor = vertical === 'top' ? Astal.WindowAnchor.TOP : Astal.WindowAnchor.BOTTOM;
    const horizontal_anchor = horizontal === 'left' ? Astal.WindowAnchor.LEFT : Astal.WindowAnchor.RIGHT;

    return (
        <window
            name={`corner-${vertical}-${horizontal}`}
            cssClasses={['corner', vertical, horizontal]}
            gdkmonitor={gdkmonitor}
            anchor={vertical_anchor | horizontal_anchor}
            application={app}
            layer={Astal.Layer.BOTTOM}
            visible
        >
            {drawing_area(vertical, horizontal)}
        </window>
    );
};

export {
	Vertical,
	Horizontal,	
}