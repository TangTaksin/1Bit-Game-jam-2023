extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	change_scene()
	pass


func _on_door_transition_body_entered(body: Node2D) -> void:
	print(body.name)
	if  body.name == "Player":
		global.transition_scene = true


func _on_door_transition_body_exited(body: Node2D) -> void:
	if  body.name == "Player":
		global.transition_scene = false
		
		
func change_scene():
	if global.transition_scene == true:
		if global.currrent_scene == "world":
			get_tree().change_scene_to_file("res://Scenes/levels/1/level_1.tscn")
			global.finish_changescene_world()
