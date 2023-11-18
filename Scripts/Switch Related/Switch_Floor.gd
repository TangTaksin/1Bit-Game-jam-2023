extends Switch
class_name Floor_Switch

@export var isToggle : bool
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer
var bodyCount : int = 0

func _on_body_entered(body: Node2D) -> void:
	print(body.name)
	
	if bodyCount <= 0 :
		audio_player.play()
		flipTheSwitch()
	
	bodyCount += 1

func _on_body_exited(body: Node2D) -> void:
	bodyCount -= 1
	
	if !isToggle and bodyCount <= 0: 
		audio_player.play()
		flipTheSwitch()
