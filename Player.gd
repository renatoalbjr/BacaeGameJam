extends CharacterBody2D

@export var SPEED = 300
@export var JUMP_VELOCITY = 500

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var sprite = $AnimatedSprite2D

func _physics_process(delta):
	# Add the gravity.
#	if not is_on_floor():
#		velocity.y += gravity * delta
#		sprite.play("on_air")

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		sprite.play("jump_squat")
		if sprite.is_playing() and sprite.animation == "jump_squat":
			return
		velocity.y = -JUMP_VELOCITY
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("run_left", "run_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if is_on_floor():
		if direction == 0.0:
			sprite.play("idle")
		else:
			sprite.play("run")
		
	if not is_on_floor():
		velocity.y += gravity * delta
		sprite.play("on_air")
		
	if direction > 0.0:
		sprite.flip_h = false
	elif direction < 0.0:
		sprite.flip_h = true

	if Input.is_action_just_pressed("ui_down"):
		if $Inventory.has_node("Item1"):
			$Inventory/Item1.use_item()
			

	move_and_slide()





func _on_hitbox_body_entered(body):
	if body.is_in_group("Enemy"):
		queue_free()


