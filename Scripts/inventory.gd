extends Resource
class_name Inventory

@export var itemList : Array[Item]

var currentItemIndex : int
var invIsUp : bool

signal currentItem_Changed

func SwitchVir() :
	
	if (currentItemIndex < 4) :
		currentItemIndex = currentItemIndex + (4)
		
	elif (currentItemIndex > 3) :
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

