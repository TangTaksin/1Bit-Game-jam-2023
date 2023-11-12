extends CharacterBody2D
class_name Player

@export var speed: float = 300
@export var has_acceleration = false
@export var acceleration = 1000
@export var deacceleration = 1000
@export var inventory : Inventory

var playerFacing : Vector2 = Vector2.UP
var direction : Vector2

var carried_item: Node2D = null

var CanAct : bool = true

@onready var actionCD : Timer = $ActionCoolDown
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var interaction_area: Area2D = $InteractionArea

func _physics_process(delta: float) -> void:	
	
	handleAnimation()
	handleInteraction()
	
	if carried_item != null:
		carried_item.global_position = global_position + Vector2(0, -19)
	
	if has_acceleration:
		if direction.length() == 0.0:
			velocity = velocity.move_toward(Vector2.ZERO, deacceleration * delta)
		else:
			velocity = velocity.move_toward(direction * speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(direction * speed, acceleration * delta)
	
	if !inventory.invIsUp and CanAct :
		move_and_slide()
		if Input.is_action_just_pressed("Use_Item") :
			CanAct = false
			actionCD.start()
			UseItem(playerFacing)

func _input(event: InputEvent) -> void:
	var x = Input.get_axis("ui_left", "ui_right");
	var y = Input.get_axis("ui_up", "ui_down")
	direction = Vector2(x, y).normalized()
	
	if event.is_action_pressed("ui_up") :
		playerFacing = Vector2.UP
	if event.is_action_pressed("ui_down") :
		playerFacing = Vector2.DOWN
	if event.is_action_pressed("ui_left") :
		playerFacing = Vector2.LEFT
	if event.is_action_pressed("ui_right") :
		playerFacing = Vector2.RIGHT


func handleAnimation():
	if playerFacing == Vector2.LEFT:
		if velocity.length() > 0 :
			anim_sprite.animation = "walk_side"
			anim_sprite.flip_h = true
		else :
			anim_sprite.animation = "idle_side"
			anim_sprite.flip_h = true
	if playerFacing == Vector2.RIGHT:
		if velocity.length() > 0 :
			anim_sprite.animation = "walk_side"
			anim_sprite.flip_h = false
		else :
			anim_sprite.animation = "idle_side"
			anim_sprite.flip_h = false
	if playerFacing == Vector2.UP:
		if velocity.length() > 0 :
			anim_sprite.animation = "walk_up"
		else :
			anim_sprite.animation = "idle_up"
	if playerFacing == Vector2.DOWN:
		if velocity.length() > 0 :
			anim_sprite.animation = "walk_down"
		else :
			anim_sprite.animation = "idle_down"


func handleInteraction():
	if Input.is_action_just_pressed("interact"):
		if carried_item == null:
			# Player is not carrying an item, try to pick up one
			var overlapping_items = interaction_area.get_overlapping_bodies()
			for item in overlapping_items:
				if item is StaticBody2D:
					print("Picking up item:", item)
					pickUpItem(item)
					break
		else:
			# Player is carrying an item, try to drop it
			print("Dropping item")
			dropItem()

	# Additional logic for carrying an item
	if carried_item != null:
		print("Carrying item:", carried_item)
		# You can add more logic here if needed while the player is carrying an item.

func pickUpItem(item: Node2D):
	
	print("Before picking up item - carried_item:", carried_item, "current_parent:", item.get_parent())
	carried_item = item
	var current_parent = carried_item.get_parent()
	if current_parent != null:
		current_parent.remove_child(carried_item)
		
	if carried_item is StaticBody2D:
		var collider: CollisionShape2D = carried_item.get_node("CollisionShape2D")  # Adjust the path if needed
		if collider:
			collider.set_deferred("disabled", true)
		carried_item.set_physics_process(false)
		if carried_item.get_parent() != self:
			add_child(carried_item)
	print("After picking up item - carried_item:", carried_item, "current_parent:", carried_item.get_parent())

func dropItem():
	if carried_item != null:
		# Enable the collider (assuming a CollisionShape2D)
		if carried_item is StaticBody2D:
			var collider: CollisionShape2D = carried_item.get_node("CollisionShape2D")
			if collider:
				collider.set_deferred("disabled", false)
		# Enable physics on the dropped item
		carried_item.set_physics_process(true)
		# Store the position before removing the carried item as a child
		var droppedItemPosition = global_position
		var dropDirection = playerFacing.normalized()
		carried_item.global_position = droppedItemPosition + dropDirection * 15
		carried_item.reparent(get_parent())
		
		# Reset the carried_item variable
		carried_item = null

		# Perform any additional logic when dropping an item
		print("Item dropped successfully at position:", droppedItemPosition)
	else:
		print("No item to drop")

func UseItem(dir :Vector2):
	var prefab = inventory.itemList[inventory.currentItemIndex].use(dir)
	if prefab != null :
		prefab.position = global_position
		get_parent().add_child(prefab)
	pass

func _on_active_cool_down_timeout() -> void:
	CanAct = true
	pass # Replace with function body.
