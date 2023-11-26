extends CharacterBody2D

@export var SPEED = 100
@export var ALERT_RATE = 100.0
@export var ALERT_DECREASE = 50.0

@export var LEFT_PATROL_DISTANCE = 100
@export var RIGHT_PATROL_DISTANCE = 100

var alert = 0.0

var direction = Vector2.LEFT
var is_alert = false

var starting_position

func _ready():
	starting_position = position

func _physics_process(delta):
	if !$DetectionCone.is_detecting():
		if alert >= 0.0:
			alert -= ALERT_DECREASE * delta
		if position.x <= starting_position.x - LEFT_PATROL_DISTANCE:
			direction = Vector2.RIGHT
			scale.x = -1
			print(direction.x)
		elif position.x >= starting_position.x + RIGHT_PATROL_DISTANCE:
			direction = Vector2.LEFT
			scale.x = -1
			print(direction.x)
			
		velocity = direction * SPEED
		move_and_slide()
	else:
		if alert <= 100.0:
			alert += ALERT_RATE * delta
	$TextureProgressBar.value = alert
	
	if alert >= 100.0:
		get_tree().call_group("Player", "queue_free")
