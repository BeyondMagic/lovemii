import Bar from './windows/bar';
import Corner from './windows/screen_corners';
import wifi from './windows/wifi';

const windows = [
	Bar(0),
	Corner('top', 'left'),
	Corner('top', 'right'),
	Corner('bottom', 'left'),
	Corner('bottom', 'right'),
	// wifi,
	// Calendar(),
]

export default windows
