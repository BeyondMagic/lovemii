import SCSS, { css as style } from './subprocesses/scss'
import windows from './windows';

SCSS.reload();
SCSS.launch_monitor();

export default {
	style,
	windows
}
