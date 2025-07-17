import Variable from 'resource:///com/github/Aylur/ags/variable.js'

const cycle_kanji = {
	total: 4,
	current: 0
}

// Will retrieve the current date of the system in a interval.
const date = Variable('', {
	// 1000 miliseconds = 1 minute.
	poll: [1000,
		// UNIX date command. See manual date(1).
		'date \'+<span fgalpha="50%" size="smaller" rise="1pt">%B%d%A</span> %I時%M分%p\'',
		(out : string) =>
			out
			// Make all Japanese characters with lower opacity.
			.replace(/([一-龯]+)/g, kanji => {
				let alpha = 75

				if (cycle_kanji.current < 2)
					alpha = 35

				cycle_kanji.current = (cycle_kanji.current + 1) % cycle_kanji.total

				return '<span fgalpha="' + alpha + '%">' + kanji + '</span>'
			})
		]
});

export default date
