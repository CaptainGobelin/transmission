extends Node2D

export(float) var min_scale
export(float) var max_scale

func _ready():
	get_node("StreamPlayer").play(0)