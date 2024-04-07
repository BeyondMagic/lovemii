import SCSS, { css as style } from './subprocesses/scss'
import windows from './windows';
import type { Config } from '../types/app.d.ts';

SCSS.reload();
SCSS.launch_monitor();

const configuration : Config = {
	style,
	windows,
	onWindowToggled (window_name : string, visible : boolean) {
		print(window_name, visible)
	},
}

export default configuration
