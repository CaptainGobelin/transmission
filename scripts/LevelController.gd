extends Node2D

export(float) var min_scale
export(float) var max_scale
export(String) var music

func _ready():
	get_node("../SamplePlayer").play(music)