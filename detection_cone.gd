extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func is_detecting():
	var colliders = [
		$RayCast2D1,
		$RayCast2D2,
		$RayCast2D3,
		$RayCast2D4,
		$RayCast2D5
	]
	for raycast in colliders:
		if raycast.is_colliding():
			var colliding_body = raycast.get_collider()
			if colliding_body and colliding_body.is_in_group("Player"):
				return true
	return false
