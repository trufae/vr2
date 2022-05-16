module main

import ui
import gx
import time
import radare.r2

struct App {
mut:
	window   &ui.Window = 0
	shell    &ui.Window = 0
	msg      string
	core     &r2.RCore = 0
	filename string
}

fn main_cancel(mut app App, btn &ui.Button) {
	exit(0)
}

fn main_open(mut app App, btn &ui.Button) {
	app.window.close() // doesnt work
	time.sleep(20 * time.millisecond)
	ui.run(app.shell)
	// ui.run(app.shell)
	eprintln('This is great')
	// cji	mut tb := app.window.textbox('tb')
	//	go wait_complete(mut app, mut tb)
}

fn r2shell() {
}

fn main() {
	mut app := &App{
		filename: '/bin/ls'
	}
	app.shell = ui.window(state: app)
	app.window = ui.window(
		state: app
		bg_color: gx.white
		width: 220
		height: 200
		mode: .max_size
		children: [
			ui.column(
				margin: ui.Margin{5, 5, 5, 5}
				spacing: 5
				widths: ui.stretch
				alignments: ui.HorizontalAlignments{
					center: [0]
					right: [1]
				}
				children: [ui.picture(
					path: 'icon.png'
				),
					ui.row(
						children: [
							ui.label(text: ' path:  '),
							ui.textbox(
								is_focused: true
								width: 170
								text: &app.filename
							),
						]
					),
					/*
					ui.textbox(
						id: 'tb'
						is_multiline: true
						text: &app.msg
						height: 200
						is_sync: true
						// is_wordwrap: true
						// scrollview: true
						read_only: true
						// text_size: 20
					),
					*/
					ui.row(
						spacing: 5
					)
					ui.row(
						spacing: 5
						alignments: ui.VerticalAlignments{
							bottom: [
								0,
							]
						}
						children: [
							ui.button(width: 100, text: '❌ Cancel', onclick: main_cancel),
							ui.button(width: 100, text: '📂 Open File', onclick: main_open),
						]
					)]
			),
		]
	)
	// eprintln(app.window.ui.styles['default'].to_toml())
	ui.run(app.window)
}
