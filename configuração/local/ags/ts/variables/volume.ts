import Variable from 'resource:///com/github/Aylur/ags/variable.js'

/*
 * Will retrive the current volume upon updates.
 */
export type Volume = {
	count: number;
	msg: string;
};

const volume = Variable<Volume>({ count: 0, msg: '' }, {
	listen: ['pactl subscribe', (msg : string) => ({
		count: volume.value.count + 1,
		msg: msg,
	})],
});

// volume.connect('changed', ({ value }) => {
// 	print(value.msg, value.count);
// });

export default volume;
