extends Item

var arrow = preload("res://Scenes/Item/arrow.tscn")

func _init() -> void:
	set_local_to_scene(true)

func use(dir):
	var a = arrow.instantiate() as Arrow
	a._init(dir)
	
	return a

