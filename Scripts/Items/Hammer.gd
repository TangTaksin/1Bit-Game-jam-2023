extends Node2D
class_name Hammer

var direction : Vector2

@export var up_sprite : Texture2D
@export var down_sprite : Texture2D
@export var side_sprite : Texture2D
@export var diagup_sprite : Texture2D
@export var diagdown_sprite : Texture2D

@onready var sprite : Sprite2D = $Sprite2D
@onready var timer = $Timer

func _init(dir : Vector2 = Vector2.LEFT) -> void:
	direction = dir

func _ready() -> void:
	position += direction * 16
	
	if direction == Vector2.UP :
		sprite.texture = up_sprite
	if direction == Vector2.DOWN :
		sprite.texture = down_sprite
	if direction == Vector2.LEFT :
		sprite.texture = side_sprite
		sprite.set_flip_h(true)
	if direction == Vector2.RIGHT :
		sprite.texture = side_sprite
		sprite.set_flip_h(false)
	if direction.x > 0 and direction.y < 0 : #UpRight
		sprite.texture = diagup_sprite
		sprite.set_flip_h(true)
	if direction.x > 0 and direction.y > 0 : #DownRight
		sprite.texture = diagdown_sprite
		sprite.set_flip_h(true)

func _on_timer_timeout() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is Switch and not body is Floor_Switch:
		body.flipTheSwitch()
	
	if body is Destructible :
		body.destroy()
