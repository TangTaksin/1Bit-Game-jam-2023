extends Control
class_name Interface

@onready var inventory = preload("res://Resources/inventory.tres")
@onready var panel = $Panel
@onready var select = $Panel/Select
@onready var curItem = $Slot/CurrentItemIcon

@export var itemIcons : Array[TextureRect]
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var ui_sfx: AudioStreamPlayer = $uiSFX

var panelIsUp = false

func _ready() -> void:
	panel.visible = false
	inventory.currentItem_Changed.connect(UpdateInterface)
	
	UpdateInterface()
	for i in range(0, inventory.itemList.size()):
		itemIcons[i].texture = inventory.itemList[i].image
		pass

func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("Inventory") :
		audio_player.play()
		ToggleInventory()
		
	if panelIsUp :
		Selection()
		pass

func ToggleInventory() :
	
	panelIsUp = !panelIsUp
	panel.visible = panelIsUp
	inventory.invIsUp = panelIsUp
	

func Selection() :
	
	if (Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right")) :
		ui_sfx.play()
		var x = Input.get_axis("move_left", "move_right");
		inventory.SwitchHor(x)
	
	if (Input.is_action_just_pressed("move_up") or Input.is_action_just_pressed("move_down")) :
		ui_sfx.play()
		inventory.SwitchVir()
	
	pass

func UpdateInterface() :
	# Current Item Icon
	curItem.texture = inventory.itemList[inventory.currentItemIndex].image
	# current cursor position
	select.set_global_position(itemIcons[inventory.currentItemIndex].get_global_position() - (Vector2.ONE * 3))
	
	pass

