extends CharacterBody2D
class_name Player

const CARRIED_ITEM_OFFSET = Vector2(0, -19)
const DROP_ITEM_DISTANCE = 16
const MAX_STAMINA = 100

# Exported Variables
@export var speed: float = 80
@export var run_speed: float = 120
@export var has_acceleration = false
@export var acceleration = 1000
@export var deacceleration = 1000
@export var inventory: Inventory


# Internal Variables
var playerFacing: Vector2 = Vector2.UP
var direction: Vector2

var carried_item: Node2D = null

var CanAct: bool = true
var stamina: float = MAX_STAMINA

# OnReady Variables
@onready var actionCD: Timer = $ActionCoolDown
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var interaction_area: Area2D = $InteractionArea
@onready var audio_player = $AudioStreamPlayer
@onready var audio_walkSFX = $walkSFX

func _physics_process(delta: float) -> void:
	handle_movement(delta)
	handle_animation()
	
	handle_interaction()
	handle_inventory()
	
	if  Input.is_action_pressed("run") and stamina > 0 and !inventory.itemList[5].item_disabled:
		speed = run_speed
		stamina -= delta * 20
		if stamina < 0:
			stamina = 0
		print(stamina)
	else:
		speed = 80
		stamina = min(stamina + delta * 5, MAX_STAMINA)
		print(stamina)

func handle_movement(delta):
	
	var x = Input.get_axis("move_left", "move_right");
	var y = Input.get_axis("move_up", "move_down")
	direction = Vector2(x, y).normalized()
	
	var new_direction = direction.normalized()
	if has_acceleration:
		if new_direction.length() == 0.0:
			velocity = velocity.move_toward(Vector2.ZERO, deacceleration * delta)
		else:
			velocity = velocity.move_toward(direction * speed, acceleration * delta)
			
	else:
		velocity = new_direction * speed

	if new_direction.length() > 0.0:
		if ! inventory.invIsUp and CanAct:
			playerFacing = new_direction
	

func handle_animation():
	if playerFacing == Vector2.LEFT:
		if velocity.length() > 0:
			play_walking_sfx()
			anim_sprite.animation = "walk_side"
			anim_sprite.flip_h = true
		else:
			anim_sprite.animation = "idle_side"
			anim_sprite.flip_h = true
	if playerFacing == Vector2.RIGHT:
		if velocity.length() > 0:
			play_walking_sfx()
			anim_sprite.animation = "walk_side"
			anim_sprite.flip_h = false
		else:
			anim_sprite.animation = "idle_side"
			anim_sprite.flip_h = false
	if playerFacing == Vector2.UP:
		if velocity.length() > 0:
			play_walking_sfx()
			anim_sprite.animation = "walk_up"
		else:
			anim_sprite.animation = "idle_up"
	if playerFacing == Vector2.DOWN:
		if velocity.length() > 0:
			play_walking_sfx()
			anim_sprite.animation = "walk_down"
		else:
			anim_sprite.animation = "idle_down"

func play_walking_sfx():
	if !audio_walkSFX.is_playing():
		audio_walkSFX.play()

func handle_interaction():
	if carried_item != null:
		carried_item.global_position = global_position + CARRIED_ITEM_OFFSET

	if Input.is_action_just_pressed("interact"):
		if carried_item == null:
			# Player is not carrying an item, try to pick up one
			var overlapping_items = interaction_area.get_overlapping_bodies()
			for item in overlapping_items:
				if item is Chest :
					item.return_item()
					break
				if item is StaticBody2D and !inventory.itemList[4].item_disabled:
					print("Picking up item:", item)
					pick_up_item(item)
					break
		else:
			# Player is carrying an item, try to drop it
			print("Dropping item")
			drop_item()

	# Additional logic for carrying an item
	if carried_item != null:
		print("Carrying item:", carried_item)
		# You can add more logic here if needed while the player is carrying an item.

func handle_inventory():
	if ! inventory.invIsUp and CanAct:
		move_and_slide()
		if Input.is_action_just_pressed("Use_Item"):
			CanAct = false
			actionCD.start()
			use_item(playerFacing)
			audio_player.play()

func pick_up_item(item: Node2D):

	print("Before picking up item - carried_item:", carried_item, "current_parent:", item.get_parent())
	carried_item = item
	var current_parent = carried_item.get_parent()
	if current_parent != null:
		current_parent.remove_child(carried_item)

	if carried_item is StaticBody2D:
		#playSFX
		audio_player.play()
		var collider: CollisionShape2D = carried_item.get_node_or_null("CollisionShape2D")  # Adjust the path if needed
		if collider:
			collider.set_deferred("disabled", true)
		carried_item.set_physics_process(false)
		if carried_item.get_parent() != self:
			add_child(carried_item)
	print("After picking up item - carried_item:", carried_item, "current_parent:", carried_item.get_parent())

func drop_item():
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
		carried_item.global_position = droppedItemPosition + dropDirection * DROP_ITEM_DISTANCE
		carried_item.reparent(get_parent())
		#playSFX
		audio_player.play()
		#remove_child(carried_item)

		# Reset the carried_item variable
		carried_item = null

		# Perform any additional logic when dropping an item
		print("Item dropped successfully at position:", droppedItemPosition)
	else:
		print("No item to drop")

func use_item(dir: Vector2):
	var item = inventory.itemList[inventory.currentItemIndex].use(dir)
	var prefab

	if item != null:
		prefab = item[0]
		if item[1] == false:
			prefab.position = global_position
			get_parent().add_child(prefab)
		else:
			add_child(prefab)
	pass

func _on_active_cool_down_timeout() -> void:
	CanAct = true
	pass  # Replace with function body.

