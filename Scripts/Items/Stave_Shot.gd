extends Node2D
class_name Stave_Shot

@export var arrowSpeed : float = 250

var direction : Vector2 = Vector2.RIGHT

@onready var timer = $Timer

func _init(dir : Vector2 = Vector2.DOWN) -> void:
	direction = dir

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += direction * arrowSpeed * delta
	pass

func _on_timer_timeout() -> void:
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body)
	if body is Switch :
		body.flipTheSwitch()
		print("switch is flipped")
	if body is Magic_Floor :
		body.set_state(false)
	
	if body.name != "Player" :
		queue_free()
