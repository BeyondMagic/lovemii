import App from 'resource:///com/github/Aylur/ags/app.js'
import { exec as execute, monitorFile as monitor} from 'resource:///com/github/Aylur/ags/utils.js';

const config_folder = App.configDir

export const css = config_folder + '/style.css'
const scss_folder = config_folder + '/scss'

// Reload the SCSS file in the application itself.
export function reload () : void {

	const scss = scss_folder + '/main.scss'

	console.log('[SCSS monitor] SCSS reloaded.')

	execute(`sassc ${scss} ${css}`)

	App.resetCss()
	App.applyCss(css)
}

// Will compile the SCSS file upon changes.
export function launch_monitor () {
	let count = 0

	// FIXIT: monitorFile is launching the anonymous function inside of Utils.monitorFile 12 times in less than a second. We can ignore 12 times.
	const MAGIC_NUMBER = 13;

	monitor(
		scss_folder,
		() => {
			if (count++ % MAGIC_NUMBER)
				// console.warn("[SCSS monitor] still changing latest files.");
				return

			count = (count + 1) % MAGIC_NUMBER
			reload()
		}
	)
}

const SCSS = {
	reload,
	launch_monitor
}

export default SCSS
