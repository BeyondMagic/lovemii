import App from 'resource:///com/github/Aylur/ags/app.js';
import Utils from 'resource:///com/github/Aylur/ags/utils.js';
const config_folder = App.configDir
const scss_folder = `${config_folder}/scss`
const scss = `${scss_folder}/main.scss`;
export const css = `${config_folder}/style.css`;

// FIXIT: monitorFile is launching the anonymous function inside of Utils.monitorFile 12 times in less than a second. We can ignore 11 times.
const MAGIC_NUMBER = 13;

function reload () : void {
	console.log('[SCSS monitor] SCSS reloaded.');
	Utils.exec(`sassc ${scss} ${css}`);
	App.resetCss();
	App.applyCss(css);
}

/*
 * Will compile the SCSS file upon changes.
 */
function launch_monitor () {
	let count = 0;
	Utils.monitorFile(
		scss_folder,
		() => {
			if (count++ % MAGIC_NUMBER)
			{
				console.warn("[SCSS monitor] still changing latest files.");
				return;
			}
			count = (count + 1) % MAGIC_NUMBER;
			reload();
		},
		'directory'
	);
}

const SCSS = { reload, launch_monitor };

export default SCSS
