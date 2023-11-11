extends Resource

class_name Item

@export var itemname : String = ""
@export var image : Texture2D

func use() ->void:
	print("Item used")
	pass

