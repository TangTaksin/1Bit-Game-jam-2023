extends Node2D


@onready var ui = $Control
@onready var invRes : Inventory = preload("res://Resources/inventory.tres")

@export var disableGlove : bool
@export var disableBoot : bool

func _ready() -> void:
	invRes.set_item_disable(4, disableGlove)
	invRes.set_item_disable(5, disableBoot)
	ui.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body:Node2D) -> void:
	ui.show()
