extends Node2D

@export var NextStage : PackedScene

@onready var music = get_node("../AudioStreamPlayer")

func _ready():
	music.playing = true


func _on_goal_area_entered(area):
	var next_stage = NextStage.instantiate()
	get_tree().root.add_child(next_stage)
	queue_free()


func _on_enemy_player_caught():
	$Player.queue_free()
