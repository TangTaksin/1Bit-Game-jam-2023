extends Node
class_name Chest

@onready var invRes : Inventory = preload("res://Resources/inventory.tres")
@onready var itemSprite = $Sprite2D
@onready var animPlayer = $AnimationPlayer
#chest that you put item in
signal item_returned

@export_range(0,3) var item_to_returned : int

func return_item() :
	itemSprite.texture = invRes.itemList[item_to_returned].image
	animPlayer.current_animation = "open"
	invRes.set_item_disable(item_to_returned, true)
	item_returned.emit()
