import SCSS, { css as style } from './subprocesses/scss';
import Bar from './widgets/bar';
import Corner from './widgets/screencorners';

SCSS.reload();
SCSS.launch_monitor();

const windows = [
	Corner('top', 'left'),
	Corner('top', 'right'),
	Corner('bottom', 'left'),
	Corner('bottom', 'right'),
	Bar(0),
	// Calendar(),
]

export default {
	windows,
	style
}
