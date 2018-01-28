extends Node2D

export(String,FILE) var json_path
onready var player = get_node("../../../Player")
onready var label = get_node("Label")
onready var timer = get_node("Timer")
export(NodePath) var ui_path
var ui
var data = {}
var gui_label
var is_cursor_on = false
var dialogue = null
var next_dialogue = 0
var take_used = false
var first_try = true
export(bool) var can_take

func _ready():
	if ui_path:
		ui = get_node(ui_path)
	gui_label = get_node("../../../Label")
	var file = File.new()
	file.open(json_path, File.READ)
	var json_str = file.get_as_text()
	file.close()
	data.parse_json(json_str)
	connect("mouse_enter", self, "on_mouse_enter_object", [data.name])
	connect("mouse_exit", self, "on_mouse_exit_object")
	timer.connect("timeout", self, "play_dialogue")
	set_process_input(true)

func play_dialogue(n=next_dialogue, texts=null):
	label.text = ""
	if (texts != null):
		dialogue = texts
	if (n < dialogue.size()):
		label.text = dialogue[n]
		next_dialogue = n + 1
		timer.set_wait_time(1.5)
		timer.start()
	else:
		next_dialogue = 0

func cut_dialogue():
	timer.stop()
	next_dialogue = 0
	label.text = ""

func _input(event):
	if (is_cursor_on and event.type==InputEvent.MOUSE_BUTTON and event.pressed and event.button_index==BUTTON_LEFT):
		player.go_to(get_node("goToPoint").get_global_pos(), get_path(), false)
		first_try = false
	else:
		if (is_cursor_on and event.type==InputEvent.MOUSE_BUTTON and event.pressed and event.button_index==BUTTON_RIGHT):
			if (ui_path != null):
				is_cursor_on = false
				open_ui()
			else:
				if (first_try or not can_take):
					player.go_to(get_node("goToPoint").get_global_pos(), get_path(), false)
					first_try = false
				else:
					player.go_to(get_node("goToPoint").get_global_pos(), get_path(), true)

func on_mouse_enter_object(object_name):
	gui_label.text = object_name
	is_cursor_on = true

func on_mouse_exit_object():
	gui_label.text = ""
	is_cursor_on = false

func open_ui(node = "", function = ""):
	if ui:
		if not ui.get("termnode") == null:
			ui.termnode = node
			ui.termfunction = function
		ui.show()
		player.set_process_input(false)

func _on_Stanley_draw():
	hide()
