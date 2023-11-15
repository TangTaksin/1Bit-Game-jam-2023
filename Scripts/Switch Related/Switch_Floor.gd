extends Switch

@export var isToggle : bool
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

func _on_body_entered(body: Node2D) -> void:
	print(body.name)
	audio_player.play()
	flipTheSwitch()

func _on_body_exited(body: Node2D) -> void:
	if !isToggle :
		audio_player.play()
		flipTheSwitch()
