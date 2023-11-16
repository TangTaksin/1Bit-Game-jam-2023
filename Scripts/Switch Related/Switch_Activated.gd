extends Node2D
class_name Switch_Activated

@export var connected_Switch: Array[Switch]
@export var default_state: bool

var isActivated: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if connected_Switch != null:
		for switch in connected_Switch:
			switch.switchToggle.connect(toggle_state)
	_on_ready()

#additional function in case you what to add something to _ready() in the inherited class
func _on_ready():
	state_check()
	pass

func toggle_state():
	var check_activeted = false
	for switch in connected_Switch:
		if switch.switchIsOn:
			check_activeted = true
		else:
			check_activeted = false
			break

	if check_activeted == true:
		isActivated = ! default_state
	else:
		isActivated = default_state

	state_check()
	print("toggled")

func state_check():
	pass
