extends Switch

@export var isToggle : bool

func _on_body_entered(body: Node2D) -> void:
	flipTheSwitch()

func _on_body_exited(body: Node2D) -> void:
	if !isToggle :
		flipTheSwitch()
