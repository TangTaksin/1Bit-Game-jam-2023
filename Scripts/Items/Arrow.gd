extends Node2D
class_name Arrow

@export var arrowSpeed : float = 1500

var direction : Vector2 = Vector2.RIGHT

@onready var timer = $Timer

func _init(dir : Vector2 = Vector2.DOWN) -> void:
	direction = dir
	rotation_degrees = rad_to_deg(direction.angle()) - 90

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
	
	if body.name != "Player" :
		queue_free()
