extends CharacterBody2D

@export var SPEED = 300.0
@export var inventory : Inventory

func _physics_process(delta: float) -> void:
	
	var x = Input.get_axis("ui_left", "ui_right");
	var y = Input.get_axis("ui_up", "ui_down")
	var direction := Vector2(x, y).normalized()
	
	velocity = direction * SPEED
	
	if !inventory.invIsUp :
		move_and_slide()
		if Input.is_action_just_pressed("Use_Item") :
			UseItem()
	

func UseItem():
	inventory.itemList[inventory.currentItemIndex].use()
	pass
