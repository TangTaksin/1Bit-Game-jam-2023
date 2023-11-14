extends Node2D
class_name Switch

@export var on_Sprite : Texture2D
@export var off_Sprite : Texture2D
@export var switchIsOn : bool = false

@onready var switchSprite = $switch_sprite

signal switchToggle()

func _ready() -> void:
	if switchIsOn :
		switchSprite.texture = on_Sprite
	else : 
		switchSprite.texture = off_Sprite

func flipTheSwitch() : 
	switchIsOn = !switchIsOn
	
	if switchIsOn :
		switchSprite.texture = on_Sprite
	else : 
		switchSprite.texture = off_Sprite
	
	switchToggle.emit()

func set_switch_state(state : bool) : 
	switchIsOn = state
	switchToggle.emit()
