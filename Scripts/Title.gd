extends Control

signal change_scene(to: String)

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/World.tscn")
	pass # Replace with function body.


func _on_options_pressed():
	pass # Replace with function body.
