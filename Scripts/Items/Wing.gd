extends Node2D
class_name Wing


@onready var iw
@onready var inventory
@export var layersToFlyOver: Array[int]
@export var original_mask: Array[bool] = [false,false,false,false,false,false,false]


var parent

func _ready() -> void:
	iw = load("res://Resources/item/eqp_item_wing.tres")
	inventory = load("res://Resources/inventory.tres")
	inventory.currentItem_Changed.connect(_on_item_changed)
	inventory.item_disabled_changed.connect(_on_item_changed)
	
	
	parent = get_parent() as CharacterBody2D
	if parent != null :
		for i in range(0,6):
			original_mask[i] = parent.get_collision_mask_value(i)
			print(original_mask[i])
		for layer in layersToFlyOver :
			#parent.set_collision_layer_value(layer, false)
			parent.set_collision_mask_value(layer, false)

func _on_tree_exiting() -> void:
	disable_effect()

func _on_item_changed():
	queue_free()

func remove_self():
	queue_free()

func disable_effect():
	for i in range(0,6):
		#parent.set_collision_layer_value(layer, true)
		parent.set_collision_mask_value(i, original_mask[i])
	iw.active = false
	
	pass
