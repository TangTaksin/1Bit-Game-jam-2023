extends CharacterBody2D
class_name Player

@export var speed: float = 300
@export var has_acceleration: = false
@export var acceleration: = 1000
@export var deacceleration: = 1000
var facing := Vector2.DOWN

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D as AnimatedSprite2D

func _physics_process(delta: float) -> void:

	handleInput(delta)
	move_and_slide()
	handleAnimation()

func handleInput(delta):
	var input := Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	if has_acceleration:
		if input.length() == 0.0:
			velocity = velocity.move_toward(Vector2.ZERO, deacceleration * delta)
		else:
			velocity = velocity.move_toward(input * speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(input * speed, acceleration * delta)

func handleAnimation():
	if velocity.x < 0:
		anim_sprite.animation = "walk_side"
		anim_sprite.flip_h = true
	elif velocity.x > 0:
		anim_sprite.animation = "walk_side"
		anim_sprite.flip_h = false
	elif velocity.y < 0:
		anim_sprite.animation = "walk_up"
	elif velocity.y > 0:
		anim_sprite.animation = "walk_down"
	else:
		if anim_sprite.animation == "walk_side":
			anim_sprite.animation = "idle_side"
		elif anim_sprite.animation == "walk_up":
			anim_sprite.animation = "idle_up"
		elif anim_sprite.animation == "walk_down":
			anim_sprite.animation = "idle_down"
