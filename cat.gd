extends CharacterBody2D

var player : Node
var SPEED
var JUMP_VELOCITY

func _ready():
	pass

func _physics_process(delta):
	var target_position = player.global_position
	if target_position - global_position >= 32:
		if target_position.y < global_position.y:
			velocity.y = JUMP_VELOCITY
		if target_position.x > global_position.x:
			velocity.x = SPEED
		elif target_position.x < global_position.x:
			velocity.x = -SPEED
	else:
		velocity = Vector2.ZERO
		
	if velocity.x > 0:
		$Sprite.flip_h = false
	elif velocity.x < 0:
		$Sprite.flip_h = true

	move_and_slide()
	
	


func _on_player_ready():
	player = get_tree().root.find_child("Player")
	print(player.name)
	SPEED = player.SPEED
	JUMP_VELOCITY = player.JUMP_VELOCITY
	process_mode = Node.PROCESS_MODE_INHERIT
