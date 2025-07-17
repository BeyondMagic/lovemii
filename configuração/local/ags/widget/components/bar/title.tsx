import { bind } from "astal";
import { hyprland } from "../../hyprland";
import config from "../../../config.json";

export function title() {
  return bind(
    hyprland,
    "focused_client"
  )
  .as(client => {
      if (!client)
        return "";

      return (
        <label
          css_classes={[
            "title"
          ]}
          label={
            bind(client, "title")
            .as(title => {
              if (title.length > config.max_title_length)
                return title.slice(0, config.max_title_length) + "...";

              return title;
            })
          }
        />
      )
  })
}