extends Node2D
class_name Destructible

@export var on_sprite : Texture2D
@export var off_sprite : Texture2D

@onready var collision = $CollisionShape2D
@onready var sprite = $Sprite2D

func destroy() :
	sprite.texture = off_sprite
	collision.set_deferred("disabled", true)
