// Add our icons for the whole GTK context.
import Gtk from 'gi://Gtk'
const theme = Gtk.IconTheme.get_default()

const path = App.configDir + '/assets/icons/'
theme.append_search_path(path)

// Execute application.
import App from 'resource:///com/github/Aylur/ags/app.js'
import { execAsync as execute } from 'resource:///com/github/Aylur/ags/utils.js'

const entry = App.configDir + '/ts/main.ts'
const outdir = '/tmp/ags/js'

try {
	await execute([
		'bun', 'build', entry,
		'--outdir', outdir,
		'--external', 'resource://*',
		'--external', 'gi://*',
	])
} catch (error) {
	console.error("Could not build the TS files.")
}

const main = await import(`file://${outdir}/main.js`)

export default main.default
