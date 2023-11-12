extends CharacterBody2D
class_name Player

@export var speed: float = 300
@export var has_acceleration = false
@export var acceleration = 1000
@export var deacceleration = 1000
var facing = Vector2.DOWN

var carried_item: Node2D = null

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var interaction_area: Area2D = $InteractionArea

func _physics_process(delta: float) -> void:	
	handleInput(delta)
	move_and_slide()
	handleAnimation()
	handleInteraction()
	if carried_item != null:
		carried_item.global_position = global_position + Vector2(0, -19)
		

func handleInput(delta):
	var input := Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	if has_acceleration:
		if input.length() == 0.0:
			velocity = velocity.move_toward(Vector2.ZERO, deacceleration * delta)
			
		else:
			velocity = velocity.move_toward(input * speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(input * speed, acceleration * delta)
	facing = input.normalized()

func handleAnimation():
	if velocity.x < 0:
		anim_sprite.animation = "walk_side"
		anim_sprite.flip_h = true
	elif velocity.x > 0:
		anim_sprite.animation = "walk_side"
		anim_sprite.flip_h = false
	elif velocity.y < 0:
		anim_sprite.animation = "walk_up"
	elif velocity.y > 0:
		anim_sprite.animation = "walk_down"
	else:
		if anim_sprite.animation == "walk_side":
			anim_sprite.animation = "idle_side"
		elif anim_sprite.animation == "walk_up":
			anim_sprite.animation = "idle_up"
		elif anim_sprite.animation == "walk_down":
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
		var dropDirection = facing.normalized()
		carried_item.global_position = droppedItemPosition + dropDirection * 20
		carried_item.reparent(get_parent())
		
		# Reset the carried_item variable
		carried_item = null

		# Perform any additional logic when dropping an item
		print("Item dropped successfully at position:", droppedItemPosition)
	else:
		print("No item to drop")

