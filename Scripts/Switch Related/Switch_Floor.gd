extends Switch
class_name Floor_Switch

@export var isToggle : bool
var bodyCount : int = 0

func _on_body_entered(body: Node2D) -> void:
	bodyCount += 1
	
	if isToggle :
		flipTheSwitch()
	else :
		bodyCheck()

func _on_body_exited(body: Node2D) -> void:
	bodyCount -= 1
	if !isToggle :
		bodyCheck()

func bodyCheck() :
	if bodyCount > 0 :
		set_switch_state(true)
	else :
		set_switch_state(false)
		pass
