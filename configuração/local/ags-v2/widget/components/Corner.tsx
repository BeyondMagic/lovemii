import { App, Astal, Gtk, Gdk } from "astal/gtk4";
import Cairo from "cairo";
import config from "../../config.json";

const radius = config.corner;
    
export type position = 'top-left' | 'top-right' | 'bottom-left' | 'bottom-right';

function drawing_area (place: position) {
    const drawing = new Gtk.DrawingArea();
    drawing.set_size_request(radius, radius);

    drawing.set_draw_func((_, cr) => {
        const context = cr as Cairo.Context;
        
        switch (place) {
            case 'top-left':
                context.arc(radius, radius, radius, Math.PI, 3 * Math.PI / 2);
                context.lineTo(0, 0);
                break;

            case 'top-right':
                context.arc(0, radius, radius, 3 * Math.PI / 2, 2 * Math.PI);
                context.lineTo(radius, 0);
                break;

            case 'bottom-left':
                context.arc(radius, 0, radius, Math.PI / 2, Math.PI);
                context.lineTo(0, radius);
                break;

            case 'bottom-right':
                context.arc(0, 0, radius, 0, Math.PI / 2);
                context.lineTo(radius, radius);
                break;
        };
        context.closePath();
        context.setSourceRGBA(0, 0, 0, 1);
        context.fill();
    });
    return drawing;
};

export function Corner (position: position, monitor: number) {

    const is_top = position.startsWith('top');
    const is_left = position.endsWith('left');
    
    const vertical_anchor = is_top ? Astal.WindowAnchor.TOP : Astal.WindowAnchor.BOTTOM;
    const horizontal_anchor = is_left ? Astal.WindowAnchor.LEFT : Astal.WindowAnchor.RIGHT;

    const [vertical_suffix, horizontal_suffix] = position.split('-');

    return (
        <window
            name={`corner-${vertical_suffix}-${horizontal_suffix}`}
            cssClasses={['corner', vertical_suffix, horizontal_suffix]}
            monitor={monitor}
            anchor={vertical_anchor | horizontal_anchor}
            application={App}
            layer={Astal.Layer.BOTTOM}
            visible
        >
            {drawing_area(position)}
        </window>
    );
};