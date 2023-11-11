extends CharacterBody2D

@export var SPEED = 300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta: float) -> void:
	
	var x = Input.get_axis("ui_left", "ui_right");
	var y = Input.get_axis("ui_up", "ui_down")
	var direction := Vector2(x, y).normalized()
	
	velocity = direction * SPEED

	move_and_slide()
