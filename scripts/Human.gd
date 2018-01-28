extends Sprite

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	update_scale()
	update_z()
	set_fixed_process(false)
	
func update_z():
	set_z(get_global_pos().y/1000)

func update_scale():
	var z = 1 - get_global_pos().y / Globals.get("display/height")
	var minS = get_node("..").current_level.min_scale
	var maxS = get_node("..").current_level.max_scale
	var scale_ratio = minS + z*(maxS-minS)
	get_node("..").set_scale(Vector2(maxS,maxS).linear_interpolate(Vector2(minS,minS), z))