import os
import time
import term

fn main() {
	if os.args.len < 2 {
		println(term.bright_red('Usage: ') + term.red(os.args[0] + ' <package.id>'))
		return
	}
	app := os.args[1]
	mut last := -1
	for {
		previous := last
		last = track(app)
		if previous != -1 && previous != last {
			if previous < last {
				println(term.red(' (+ ' + (f32(last - previous) / last * 100).str() + '%)'))
			} else {
				println(term.green(' (- ' + (f32(previous - last) / last * 100).str() + '%)'))
			}
		} else {
			println('')
		}
		time.sleep(time.second * 1)
	}
}

fn track(app string) int {
	output := os.execute('adb shell dumpsys meminfo').output
	if output.contains('no devices/emulators found') {
		print(term.bright_red(output)) // print instead of println since the output is already terminated with a newline
		exit(1)
	}
	output.replace('\r\n', '\n')
	for line in output.split('\n') {
		if line.contains(app) {
			print(line.trim_space())
			return (line.split('K')[0]).replace(',', '').trim_space().int()
		}
	}
	return -1
}
