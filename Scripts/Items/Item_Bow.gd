extends Item

var arrow = preload("res://Scenes/Item/arrow.tscn")

func use(dir):
	if !item_disabled :
		var a = arrow.instantiate() as Arrow
		a._init(dir)
		
		return [a, false]

