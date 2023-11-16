extends Node

var currrent_scene = "world"
var transition_scene = false

var player_enter_door_posx = 0
var player_enter_door_posy = 0
var player_start_posx = 0
var player_start_posy = 0

var game_first_loadin = true


func  finish_changescene_world():
	if transition_scene == true:
		transition_scene = false
		if  currrent_scene == "world":
			currrent_scene = "level_1"
		else :
			currrent_scene == "world"
			
			
func finish_changescene_level_1():
	if transition_scene == true:
		transition_scene = false
		if currrent_scene =="level_1":
			currrent_scene = "level_2"
		else :
			currrent_scene == "level_1"
			
