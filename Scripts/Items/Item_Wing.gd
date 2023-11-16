extends Item
class_name Item_wing
#return {"x":x, "y":y}
var wing = preload("res://Scenes/Item/Wing.tscn")
var active : bool = false
var w

func use(dir):
	if !active :
		active = true
		w = wing.instantiate() as Wing
		return [w, true] # return wing scene, and tell the player to add it as a child.
	else :
		active = false
		w.remove_self()
