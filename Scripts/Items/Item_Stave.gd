extends Item

var staff_shot = preload("res://Scenes/Item/Stave_Shot.tscn")

func use(dir):
	if !item_disabled :
		var s = staff_shot.instantiate() as Stave_Shot
		s._init(dir)
		
		return [s, false]
