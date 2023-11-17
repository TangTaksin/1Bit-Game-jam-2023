extends Switch_Activated

@export var on_Sprite : Texture2D
@export var off_Sprite : Texture2D

@onready var gateSprite := $GateSprite
@onready var collision : CollisionShape2D = $GateStaticBody/CollisionShape2D



func state_check() :
	if isActivated :
		gateSprite.texture = on_Sprite
		collision.set_deferred("disabled", false)
	else : 
		gateSprite.texture = off_Sprite
		collision.set_deferred("disabled", true)
	pass
