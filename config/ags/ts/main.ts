import SCSS, { css } from './subprocesses/scss';
import Bar from './widgets/bar';
import Corner from './widgets/screencorners';

SCSS.reload();
SCSS.launch_monitor();

export default {
	windows: [
		Corner('top', 'left'),
		Corner('top', 'right'),
		Corner('bottom', 'left'),
		Corner('bottom', 'right'),
		Bar(0)
	],
	style: css
}
