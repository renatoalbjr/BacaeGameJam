extends Node2D

@export var duration: int = 5
@export var move_direction: Vector2 = Vector2.RIGHT
@export var distance: float = 0

var animation_player: AnimationPlayer;
var animatable_body: AnimatableBody2D;

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player = $AnimatableBody/AnimationPlayer
	animatable_body = $AnimatableBody
	var end = Vector2.from_angle(move_direction.angle()) * distance;
	var animation = Animation.new();
	var track_index = animation.add_track(Animation.TYPE_ANIMATION)
	animation.track_set_path(track_index, animatable_body.get_path());
	animation.track_insert_key(track_index, 0, Vector2.ZERO)
	animation.track_insert_key(track_index, duration, end)
	animation.track_insert_key(track_index, duration*2, Vector2.ZERO)
	
	var library = AnimationLibrary.new();
	library.add_animation("default", animation);
	
	animation_player.add_animation_library("default", library)
	animation_player.play("default")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
