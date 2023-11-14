extends Switch

@export var isToggle : bool

func _on_body_entered(body: Node2D) -> void:
	print(body.name)
	flipTheSwitch()

func _on_body_exited(body: Node2D) -> void:
	if !isToggle :
		flipTheSwitch()
