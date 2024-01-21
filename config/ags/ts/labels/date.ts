import Variable from 'resource:///com/github/Aylur/ags/variable.js'

/*
 * Will retrieve the current date of the system in a interval.
 */
const date = Variable('', {
	poll: [1000, "date '+%B %e%A %I時%M分%p'"],
});

export default date;
