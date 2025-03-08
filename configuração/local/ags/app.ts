import { App, Gtk, Astal } from "astal/gtk4";
import Hyprland from "gi://AstalHyprland";

import style from "./scss/style.scss";

import Corner from "./widget/components/Corner";
import Bar from "./widget/Bar";

App.start({
  icons: `${SRC}/assets`,
  css: style,
  main() {
    const hyprland = Hyprland.get_default();
    hyprland.get_monitors().map((monitor) => {
      Bar(monitor.id);
      Corner('top-left', monitor.id);
      Corner('top-right', monitor.id);
      Corner('bottom-left', monitor.id);
      Corner('bottom-right', monitor.id);
    });
  },
  requestHandler(request: string, res: (response: any) => void) {
    // switch (request) {
    //   case "applauncher":
    //     App.toggle_window("Applauncher");
    //     break;
    //   case "dashboard":
    //     App.toggle_window("Dashboard");
    //     break;
    //   case "pldashboard":
    //     App.toggle_window("PlayerDashboard");
    //     break;
    //   case "poweractions":
    //     App.toggle_window("PowerActions");
    //     break;
    //   case "clearnotification":
    //     clearLastNotification();
    //     break;
    // }
    // return res("toggled window");
  },
});
