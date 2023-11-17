extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	change_scene_to_End_scene()
	pass



func _on_door_transition_enter_body_exited(body:Node2D) -> void:
	if  body.name == "Player":
		global.transition_scene = true
	pass # Replace with function body.

func _on_door_transition_enter_body_entered(body:Node2D) -> void:
	if  body.name == "Player":
		global.transition_scene = false
	pass # Replace with function body.



func change_scene_to_End_scene():
	if global.transition_scene == true:
		if global.currrent_scene == "level3":
			get_tree().change_scene_to_file("res://Scenes/levels/level_2.tscn")
			global.finish_changescene_end()
