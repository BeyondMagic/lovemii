import Variable from 'resource:///com/github/Aylur/ags/variable.js'

/*
 * Will retrieve the current date of the system in a interval.
 */
const date = Variable('', {
	poll: [1000, "date '+%B%e%A %I時%M分%p'", (out : string) => out.replace(/([一-龯]+)/g, '<span fgalpha="75%">$1</span>')],
});

export default date;
