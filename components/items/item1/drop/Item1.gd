extends Node

var qnt = 1;

var bulletScene = preload("res://test_item_use.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func use_item():
	var bullet = bulletScene.instantiate()
#	print(get_node("../..").name)
	bullet.global_position = get_node("../..").global_position
	get_tree().root.add_child(bullet)
	print("Item used")
	qnt = qnt - 1
	if qnt <= 0:
		queue_free()
	
