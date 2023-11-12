extends StaticBody2D

var player: PlayerCharacter

func interacted():
	player.pick_up(self)
	


func picked_up():
	$Sprite2D.position = Vector2(-11,0)

