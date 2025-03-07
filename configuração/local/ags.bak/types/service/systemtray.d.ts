/// <reference types="@girs/dbusmenugtk3-0.4/dbusmenugtk3-0.4-ambient.js" />
/// <reference types="@girs/gdk-3.0/gdk-3.0-ambient.js" />
/// <reference types="@girs/gtk-3.0/node_modules/@girs/gdk-3.0/gdk-3.0-ambient.js" />
/// <reference types="@girs/gdkpixbuf-2.0/gdkpixbuf-2.0-ambient.js" />
/// <reference types="@girs/gio-2.0/gio-2.0-ambient.js" />
/// <reference types="@girs/gtk-3.0/node_modules/@girs/gio-2.0/gio-2.0-ambient.js" />
/// <reference types="@girs/nm-1.0/node_modules/@girs/gio-2.0/gio-2.0-ambient.js" />
import Gio from 'node_modules/@girs/gio-2.0/gio-2.0';
import Gdk from 'node_modules/@girs/gdk-2.0/gdk-2.0?version=3.0';
import GdkPixbuf from 'node_modules/@girs/gdkpixbuf-2.0/gdkpixbuf-2.0';
import DbusmenuGtk3 from 'node_modules/@girs/dbusmenugtk3-0.4/dbusmenugtk3-0.4';
import Service from '../service.js';
export declare class TrayItem extends Service {
    private _proxy;
    private _busName;
    private _iconTheme?;
    menu?: DbusmenuGtk3.Menu;
    constructor(busName: string, objectPath: string);
    readonly activate: (event: Gdk.Event) => void;
    readonly secondaryActivate: (event: Gdk.Event) => void;
    readonly scroll: (event: Gdk.EventScroll) => void;
    readonly openMenu: (event: Gdk.Event) => void;
    get category(): string;
    get id(): string;
    get title(): string;
    get status(): string;
    get window_id(): number;
    get is_menu(): boolean;
    get tooltip_markup(): string;
    get icon(): string | GdkPixbuf.Pixbuf;
    private _itemProxyAcquired;
    private _notify;
    private _refreshAllProperties;
    private _getPixbuf;
}
export declare class SystemTray extends Service {
    private _dbus;
    private _items;
    get IsStatusNotifierHostRegistered(): boolean;
    get ProtocolVersion(): number;
    get RegisteredStatusNotifierItems(): string[];
    get items(): TrayItem[];
    readonly getItem: (name: string) => TrayItem | undefined;
    constructor();
    private _register;
    RegisterStatusNotifierItemAsync(serviceName: string[], invocation: Gio.DBusMethodInvocation): void;
}
export declare const systemTray: SystemTray;
export default systemTray;
