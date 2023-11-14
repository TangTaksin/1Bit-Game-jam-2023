extends Node2D
class_name Switch_Activated

@export var connected_Switch : Switch
@export var isActivated : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if connected_Switch != null :
		connected_Switch.switchToggle.connect(toggle_state)
	_on_ready()

#additional function in case you what to add something to _ready() in the inherited class
func _on_ready() :
	state_check()
	pass

func toggle_state() :
	isActivated = !isActivated
	state_check()
	print("toggled")

func state_check() :
	pass
