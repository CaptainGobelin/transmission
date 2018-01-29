extends Node2D

export(float) var min_scale
export(float) var max_scale

func _ready():
	get_node("StreamPlayer").play(0)
	get_node("../Label").text = ""
	get_node("..").streamPlayer = get_node("StreamPlayer")
	get_node("../Player").set_global_pos(get_node("StartPoint").get_global_pos())
	get_node("../Player").path = null