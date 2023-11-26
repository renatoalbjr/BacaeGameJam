extends Area2D

var interaction_text = null
var inside = false;

func _physics_process(delta):
	input_event()

func _ready():
	interaction_text = get_node("../Label")  # Substitua pelo caminho do nó do texto
	interaction_text.visible = false


func _on_body_entered(body):
	if body.name == "Player":  # Verifique se é o jogador que entrou na área
		interaction_text.visible = true
		set_process_input(true)
		inside = true

func _on_body_exited(body):
	if body.name == "Player":
		interaction_text.visible = false
		set_process_input(false)
		inside = false

func input_event():
	if inside and Input.is_action_just_pressed('interact'):
		print('X')
		
