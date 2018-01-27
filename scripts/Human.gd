extends Sprite

var current_level

func _ready():
	current_level = get_node("../../Player").current_level
	update_scale()
	update_z()
	
func update_z():
	set_z(get_global_pos().y/1000)

func update_scale():
	var z = 1 - get_global_pos().y / Globals.get("display/height")
	var minS = current_level.min_scale
	var maxS = current_level.max_scale
	var scale_ratio = minS + z*(maxS-minS)
	get_node("..").set_scale(Vector2(maxS,maxS).linear_interpolate(Vector2(minS,minS), z))