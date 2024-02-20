import Variable from 'resource:///com/github/Aylur/ags/variable.js'

// Will retrieve the current date of the system in a interval.
const date = Variable('', {
	// 1000 miliseconds = 1 minute.
	poll: [1000,
		'date \'+<span size="smaller" rise="1pt">%B%d%A</span> %I時%M分%p\'',
		(out : string) =>
			out
			// Make all Japanese characters with lower opacity.
			.replace(/([一-龯]+)/g, '<span fgalpha="75%">$1</span>')],
});

export default date
