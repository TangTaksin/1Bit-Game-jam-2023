extends Item

var hammer = preload("res://Scenes/Item/hammer.tscn")

func use(dir):
	var h = hammer.instantiate() as Hammer
	h._init(dir)
	
	return h
