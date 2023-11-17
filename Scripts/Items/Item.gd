extends Resource

class_name Item

@export var itemname : String = ""
@export var itemname_disable : String = ""

@export var image : Texture2D
@export var image_disable : Texture2D

@export var description : String = ""
@export var description_disable : String = ""

@export var item_disabled : bool = false

func use(dir :Vector2):
	print("Item used")
	pass
