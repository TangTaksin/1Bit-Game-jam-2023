extends Node2D
class_name Magic_Floor

@export var on_Sprite : Texture2D
@export var off_Sprite : Texture2D

var isActivated : bool = true

@onready var floor_Sprite := $Floor_Sprite
@onready var collision : CollisionShape2D = $CollisionShape2D

#additional function in case you what to add something to _ready() in the inherited class
func _on_ready() :
	state_check()
	pass

func set_state(state : bool) :
	isActivated = state
	state_check()

func state_check() :
	if isActivated :
		floor_Sprite.texture = on_Sprite
		collision.set_deferred("disabled", false)
	else : 
		floor_Sprite.texture = off_Sprite
		collision.set_deferred("disabled", true)
	pass
