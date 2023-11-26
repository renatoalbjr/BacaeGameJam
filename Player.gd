extends CharacterBody2D

@export var SPEED = 300
@export var JUMP_VELOCITY = 500

# Direção do movimento do personagem.
@export var direction = 0.0

# Variável que indica se o personagem está pulando no momento.

# Obtendo a gravidade do ambiente do jogo.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Referência ao nó do sprite animado do personagem.
@onready var sprite = $AnimatedSprite2D

func _physics_process(delta):
	# Aplicação da gravidade quando o personagem não está no chão.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Obtendo a direção do movimento baseado na entrada do jogador.
	direction = Input.get_axis("run_left", "run_right")

	# Chamada da função para lidar com a mudança de direção.
	handle_direction_change()

	# Lidando com as animações para movimento e saltos.
	if is_on_floor() and sprite.animation != "jump_squat":
		if direction == 0.0:
			sprite.play("idle")
		else:
			sprite.play("run")

	# Chamada da função para lidar com eventos de salto.
	handle_jump_event()

	# Lidando com a ação do inventário quando o botão de baixo é pressionado.
	if Input.is_action_just_pressed("ui_down"):
		if $Inventory.has_node("Item1"):
			$Inventory/Item1.use_item()

	# Movimentando o personagem com tratamento de colisão.
	move_and_slide()

func handle_direction_change():
	# Movendo o personagem na direção determinada ou desacelerando-o se nenhuma direção for pressionada.
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Invertendo o sprite com base na direção do movimento.
	if direction > 0.0:
		sprite.flip_h = false
	elif direction < 0.0:
		sprite.flip_h = true

func handle_jump_event():
	# Executando o salto se o personagem estiver na fase de "jump_squat".
	if !sprite.is_playing() and sprite.animation == "jump_squat":
		velocity.y = -JUMP_VELOCITY
		sprite.play("on_air")

	# Ativando o salto quando o botão de salto é pressionado e o personagem está no chão.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		sprite.play("jump_squat")

# Lidando com eventos de colisão.
func _on_hitbox_body_entered(body):
	if body.is_in_group("Enemy"):
		queue_free()
