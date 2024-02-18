import Bar from './windows/bar';
import Corner from './windows/screen_corners';

const windows = [
	Bar(0),
	Corner('top', 'left'),
	Corner('top', 'right'),
	Corner('bottom', 'left'),
	Corner('bottom', 'right'),
	// Calendar(),
]

export default windows
