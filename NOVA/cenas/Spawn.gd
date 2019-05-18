extends Node2D

#inimigo
onready var enemie = load("res://assets/inimigo/rato/00012.tscn")
#onready var link = load("res://assets/inimigo/rato/00012.tscn").instance()
#definida pelo mapa
onready var cena = get_parent().get_node("Cena")
onready var enemies_in_scene = cena.enemies
onready var spawn_timer = $spawn_timer
onready var spawn_wait_time = clamp(float(enemies_in_scene.size()),5,10)
var cell_position = []
var max_enemies_in_scene = 15

func _ready():

	pass 

func set_wait_time():
	spawn_timer.start()
	spawn_timer.set_wait_time(spawn_wait_time)
	pass

#reajustar função de mapas 
func spawn_enemy():
	enemies_in_scene = cena.enemies
	set_wait_time()
	if enemies_in_scene.size() <= max_enemies_in_scene:
		print(add_child(enemie.instance()))
		#print(novo.set_position(cell_position[round(rand_range(0.0,float(cell_position.size())))]))
		print("inimigo adicionado")
		print("Cell position icon :   "+str(cell_position))
		pass
	pass