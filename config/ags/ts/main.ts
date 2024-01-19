import SCSS, { css } from './subprocesses/scss';
import Bar from './widgets/bar';

SCSS.reload();
SCSS.launch_monitor();

export default {
	windows: [Bar(0)],

	style: css
}
