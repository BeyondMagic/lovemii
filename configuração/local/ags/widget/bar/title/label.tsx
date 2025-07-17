import { createBinding, With } from "ags"
import { hyprland } from "../../../services/hyprland"
import { config } from "../../../app"

export function Label ()
{
	const focused_client = createBinding(
		hyprland,
		"focused_client"
	);

	return <With value={focused_client}>
		{(client) => {
			const client_title = createBinding(client, "title");

			return <label
				css_classes={[
					"title"
				]}
				label={client && client_title(title => {
					if (!title)
						return "";

					else if (title.length > config.max_title_length)
						return title.slice(0, config.max_title_length) + "...";
					
					return title;
				})}
			/>
		}}
	</With>
}