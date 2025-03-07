
declare function print(...args: any[]): void;

declare module console {
    export function error(obj: object, others?: object[]): void;
    export function error(msg: string, subsitutions?: any[]): void;
    export function log(obj: object, others?: object[]): void;
    export function log(msg: string, subsitutions?: any[]): void;
    export function warn(obj: object, others?: object[]): void;
    export function warn(msg: string, subsitutions?: any[]): void;
}

declare module 'resource:///com/github/Aylur/ags/app.js' {
    const exports: typeof import('./app')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/overrides.js' {
    const exports: typeof import('./overrides')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/service.js' {
    const exports: typeof import('./service')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/utils.js' {
    const exports: typeof import('./utils')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/variable.js' {
    const exports: typeof import('./variable')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/widget.js' {
    const exports: typeof import('./widget')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/service/applications.js' {
    const exports: typeof import('./service/applications')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/service/audio.js' {
    const exports: typeof import('./service/audio')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/service/battery.js' {
    const exports: typeof import('./service/battery')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/service/bluetooth.js' {
    const exports: typeof import('./service/bluetooth')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/service/greetd.js' {
    const exports: typeof import('./service/greetd')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/service/hyprland.js' {
    const exports: typeof import('./service/hyprland')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/service/mpris.js' {
    const exports: typeof import('./service/mpris')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/service/network.js' {
    const exports: typeof import('./service/network')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/service/notifications.js' {
    const exports: typeof import('./service/notifications')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/service/powerprofiles.js' {
    const exports: typeof import('./service/powerprofiles')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/service/systemtray.js' {
    const exports: typeof import('./service/systemtray')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/widgets/box.js' {
    const exports: typeof import('./widgets/box')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/widgets/button.js' {
    const exports: typeof import('./widgets/button')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/widgets/calendar.js' {
    const exports: typeof import('./widgets/calendar')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/widgets/centerbox.js' {
    const exports: typeof import('./widgets/centerbox')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/widgets/circularprogress.js' {
    const exports: typeof import('./widgets/circularprogress')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/widgets/colorbutton.js' {
    const exports: typeof import('./widgets/colorbutton')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/widgets/drawingarea.js' {
    const exports: typeof import('./widgets/drawingarea')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/widgets/entry.js' {
    const exports: typeof import('./widgets/entry')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/widgets/eventbox.js' {
    const exports: typeof import('./widgets/eventbox')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/widgets/filechooserbutton.js' {
    const exports: typeof import('./widgets/filechooserbutton')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/widgets/fixed.js' {
    const exports: typeof import('./widgets/fixed')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/widgets/flowbox.js' {
    const exports: typeof import('./widgets/flowbox')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/widgets/fontbutton.js' {
    const exports: typeof import('./widgets/fontbutton')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/widgets/icon.js' {
    const exports: typeof import('./widgets/icon')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/widgets/label.js' {
    const exports: typeof import('./widgets/label')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/widgets/levelbar.js' {
    const exports: typeof import('./widgets/levelbar')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/widgets/listbox.js' {
    const exports: typeof import('./widgets/listbox')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/widgets/menu.js' {
    const exports: typeof import('./widgets/menu')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/widgets/menubar.js' {
    const exports: typeof import('./widgets/menubar')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/widgets/menuitem.js' {
    const exports: typeof import('./widgets/menuitem')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/widgets/overlay.js' {
    const exports: typeof import('./widgets/overlay')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/widgets/progressbar.js' {
    const exports: typeof import('./widgets/progressbar')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/widgets/revealer.js' {
    const exports: typeof import('./widgets/revealer')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/widgets/scrollable.js' {
    const exports: typeof import('./widgets/scrollable')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/widgets/separator.js' {
    const exports: typeof import('./widgets/separator')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/widgets/slider.js' {
    const exports: typeof import('./widgets/slider')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/widgets/spinbutton.js' {
    const exports: typeof import('./widgets/spinbutton')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/widgets/spinner.js' {
    const exports: typeof import('./widgets/spinner')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/widgets/stack.js' {
    const exports: typeof import('./widgets/stack')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/widgets/switch.js' {
    const exports: typeof import('./widgets/switch')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/widgets/togglebutton.js' {
    const exports: typeof import('./widgets/togglebutton')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/widgets/widget.js' {
    const exports: typeof import('./widgets/widget')
    export = exports
}
declare module 'resource:///com/github/Aylur/ags/widgets/window.js' {
    const exports: typeof import('./widgets/window')
    export = exports
}
declare module 'gi://Gtk' {
    const exports: typeof import('node_modules/@girs/gtk-3.0/gtk-3.0')
    export = exports
}
declare module 'gi://GObject' {
    const exports: typeof import('node_modules/@girs/gobject-2.0/gobject-2.0')
    export = exports
}
declare module 'gi://Gio' {
    const exports: typeof import('node_modules/@girs/gio-2.0/gio-2.0')
    export = exports
}
declare module 'gi://GLib' {
    const exports: typeof import('node_modules/@girs/glib-2.0/glib-2.0')
    export = exports
}
