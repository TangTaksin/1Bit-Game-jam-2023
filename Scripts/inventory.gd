extends Resource
class_name Inventory

@export var itemList : Array[Item]

var currentItemIndex : int
var invIsUp : bool

signal currentItem_Changed
signal item_disabled_changed

func SwitchVir() :
	
	if (currentItemIndex < 4) :
		if (currentItemIndex + 4 > itemList.size() - 1) :
			currentItemIndex = itemList.size() - 1
		else :
			currentItemIndex = currentItemIndex + (4)
	elif (currentItemIndex > 3) :
		if (currentItemIndex - 4 < 0) :
			currentItemIndex = 0
		else :
			currentItemIndex = currentItemIndex - (4)
	
	currentItem_Changed.emit()

func SwitchHor(x :int) :
	
	if (currentItemIndex + x > itemList.size()-1) :
		currentItemIndex = 0
		
	elif (currentItemIndex + x < 0) :
		currentItemIndex = itemList.size() -1
		
	else :
		currentItemIndex += x
	
	currentItem_Changed.emit()

func GetCurrent() -> Item:
	return itemList[currentItemIndex]

func set_item_disable(index : int, state : bool) :
	itemList[index].item_disabled = state
	item_disabled_changed.emit()
	return itemList[index]

func set_item_index_disable(index : int) :
	itemList[index].item_disabled = true
	item_disabled_changed.emit()
	return itemList[index]

