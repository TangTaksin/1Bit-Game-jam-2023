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
	print(timer.time_left)
	global_position += direction * arrowSpeed * delta
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	queue_free()
	pass # Replace with function body.
