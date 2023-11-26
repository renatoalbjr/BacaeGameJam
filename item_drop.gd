extends Area2D

@export var item : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("Player"):
		if body.find_child("Inventory").has_node("Item1"):
			body.find_child("Item1").qnt += 1
		else:
			body.find_child("Inventory").add_child(item.instantiate())
		queue_free()
