extends Node

@onready var invRes : Inventory = preload("res://Resources/inventory.tres")

var item_checks : Array[bool] = [false,false,false,false]

var currrent_scene = "world"
var transition_scene = false

var player_enter_door_posx = 0
var player_enter_door_posy = 0
var player_start_posx = 0
var player_start_posy = 0

var game_first_loadin = true


func _ready() -> void:
	invRes.item_disabled_changed.connect(update_item_checks)
	pass

func update_item_checks() :
	for i in range(0,3) :
		item_checks[i] = invRes.itemList[invRes.currentItemIndex].item_disabled
		pass

func  finish_changescene_world():
	if transition_scene == true:
		transition_scene = false
		if  currrent_scene == "world":
			currrent_scene = "level1"
		else :
			currrent_scene == "world"

func finish_changescene_level_1():
	if transition_scene == true:
		transition_scene = false
		if currrent_scene =="level1":
			currrent_scene = "level3"
		else :
			currrent_scene == "level1"

func finish_changescene_end():
	if transition_scene == true:
		transition_scene = false
		if currrent_scene =="leve3":
			currrent_scene = "level2"
	else :
		currrent_scene == "level3"
			
