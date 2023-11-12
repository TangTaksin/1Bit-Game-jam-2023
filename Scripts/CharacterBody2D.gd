extends CharacterBody2D

@export var SPEED = 300.0
@export var inventory : Inventory

@onready var actionCD : Timer = $ActionCoolDown

var playerFacing : Vector2 = Vector2.UP
var direction : Vector2
var CanAct : bool = true

func _physics_process(delta: float) -> void:
	velocity = direction * SPEED
	
	if !inventory.invIsUp and CanAct :
		move_and_slide()
		if Input.is_action_just_pressed("Use_Item") :
			CanAct = false
			actionCD.start()
			UseItem(playerFacing)

func _input(event: InputEvent) -> void:
	var x = Input.get_axis("ui_left", "ui_right");
	var y = Input.get_axis("ui_up", "ui_down")
	direction = Vector2(x, y).normalized()
	
	if event.is_action_pressed("ui_up") :
		playerFacing = Vector2.UP
	if event.is_action_pressed("ui_down") :
		playerFacing = Vector2.DOWN
	if event.is_action_pressed("ui_left") :
		playerFacing = Vector2.LEFT
	if event.is_action_pressed("ui_right") :
		playerFacing = Vector2.RIGHT

func UseItem(dir :Vector2):
	var prefab = inventory.itemList[inventory.currentItemIndex].use(dir)
	if prefab != null :
		prefab.position = global_position
		get_parent().add_child(prefab)
	pass


func _on_action_cool_down_timeout() -> void:
	CanAct = true
	pass # Replace with function body.
