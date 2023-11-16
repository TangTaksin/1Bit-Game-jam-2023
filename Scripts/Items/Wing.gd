extends Node2D
class_name Wing

@onready var inventory
@onready var item_wing
@export var layersToFlyOver: Array[int]

var parent

func _ready() -> void:
	inventory = load("res://Resources/inventory.tres")
	item_wing = load("res://Resources/item/eqp_item_wing.tres") as Item_wing
	inventory.currentItem_Changed.connect(_on_item_changed)
	parent = get_parent() as CharacterBody2D
	for layer in layersToFlyOver:
		parent.set_collision_layer_value(layer, false)
		parent.set_collision_mask_value(layer, false)

func _on_tree_exiting() -> void:
	disable_effect()

func _on_item_changed():
	queue_free()

func remove_self():
	queue_free()

func disable_effect():
	for layer in layersToFlyOver:
		parent.set_collision_layer_value(layer, true)
		parent.set_collision_mask_value(layer, true)
	item_wing.active = false
	pass
