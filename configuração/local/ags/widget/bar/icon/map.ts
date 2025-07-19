import { config } from "../../../app";

// We map the class to a predefined category set.
const map_category = new Map<string, string>();

for (const category_name of config.categories)
	for (const find of category_name.find)
		map_category.set(find, category_name.replace);

export {
	map_category
}