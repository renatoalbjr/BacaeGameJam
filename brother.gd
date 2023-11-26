extends CharacterBody2D

var distance_from_player = 25  # Distância do NPC para o jogador

# Direção do movimento do personagem.
@export var direction = 0.0

@onready var player = get_tree().get_nodes_in_group("Player")[0]


@onready var sprite = $AnimatedSprite2D

func _physics_process(delta):
	if player:
		var player_position = player.global_position

		var side_position = player_position - Vector2(distance_from_player, 5)
		
		direction = Input.get_axis("ui_left", "ui_right")
		
		handle_direction_change()
		
		
		if $RayCast2D.is_colliding() and sprite.animation != "jump_squat":
			if direction == 0.0:
				sprite.play("idle")
			else:
				sprite.play("run")
		
		handle_jump_event()

		# Definir a posição do NPC para estar ao lado do jogador
		global_position = side_position
	else:
		print('aaa')

func get_player():
	var nodes = get_tree().get_nodes_in_group("Player")
	if len(nodes) > 0:
		return nodes[0]
		
func handle_direction_change():
	# Invertendo o sprite com base na direção do movimento.
	if direction > 0.0:
		sprite.flip_h = false
	elif direction < 0.0:
		sprite.flip_h = true

func handle_jump_event():
	# Executando o salto se o personagem estiver na fase de "jump_squat".
	if !sprite.is_playing() and sprite.animation == "jump_squat":
		sprite.play("on_air")

	# Ativando o salto quando o botão de salto é pressionado e o personagem está no chão.
	if Input.is_action_just_pressed("ui_accept") and $RayCast2D.is_colliding():
		print('kkk')
		sprite.play("jump_squat")
		
# Lidando com eventos de colisão.
func _on_hitbox_body_entered(body):
	if body.is_in_group("Enemy"):
		queue_free()
