extends Area2D

var interaction_text = null

func _ready():
	interaction_text = get_node("../Label")  # Substitua pelo caminho do nó do texto
	interaction_text.visible = false


func _on_body_entered(body):
	if body.name == "Player":  # Verifique se é o jogador que entrou na área
		interaction_text.visible = true
		set_process_input(true)

func _on_body_exited(body):
	if body.name == "Player":
		interaction_text.visible = false
		set_process_input(false)


func _on_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("interact"):
		print("X")
