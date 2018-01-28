extends Area2D

export(String,FILE) var json_path
export(NodePath) var sprite
onready var player = get_node("../../../Player")
onready var timer = get_node("Timer")
var is_cursor_on = false
var data = {}
var gui_label

func _ready():
	gui_label = get_node("../../../Label")
	var file = File.new()
	file.open(json_path, File.READ)
	var json_str = file.get_as_text()
	file.close()
	data.parse_json(json_str)
	connect("mouse_enter", self, "on_mouse_enter_object", [data.name])
	connect("mouse_exit", self, "on_mouse_exit_object")
	set_process_input(true)
	
func _input(event):
	if (is_cursor_on and event.type==InputEvent.MOUSE_BUTTON and event.pressed and event.button_index==BUTTON_LEFT):
		print(sprite)
		get_node(sprite).show()
		#get_node(sprite).get_node("Label").text = data.examine
	
	
func on_mouse_enter_object(object_name):
	gui_label.text = object_name
	is_cursor_on = true

func on_mouse_exit_object():
	gui_label.text = ""
	is_cursor_on = false
