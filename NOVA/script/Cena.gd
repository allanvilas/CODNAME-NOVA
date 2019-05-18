extends Node2D

var player = preload("res://cenas/player.tscn").instance()
var mapa = preload("res://Mapas/00.tscn").instance()
var mapa1 = preload("res://Mapas/1.tscn").instance()
var menu = preload("res://menu/menu.tscn").instance()
var mapa_index = 0
var mapatual = []
var enemies = {}
var save_id = 1

var cell_magnitude = []
var cell_position = []
var mapa_used_cells = []

var new_name_player = "player"

##teste // normal = 0 // teste = 1
export var mode = 0

#xp
var valor_base = 75
var valor_randi = 12

#database
const SQLite = preload("res://lib/gdsqlite.gdns")
onready var db = SQLite.new()

var start_on = true
var pos
	
func _ready():
	#print(db.fetch_array("SELECT * FROM status;")) 
	add_child(menu)
	mapatual.append(mapa)
	mapatual.append(mapa1)
	menu.get_node("Camera2D").make_current()
	pass
	
func camera_control():
	if mode == 0:
		player.get_node("Camera2D").make_current()
	elif mode == 1:
		pass
	else: 
		player.get_node("Camera2D").make_current()
		print("FUNC:CAMERA_CONTORL=ELSE ON")
		pass
	pass

# função que zera os atributos do personagem e inicia um novo game subscrevendo o antigo save
func novo_jogo():
	#new game
	mapa_index = 0
	add_child(mapatual[mapa_index])
	add_child(player)
	camera_control()
	player._name = new_name_player
	player.nivel = 1
	player.xp = 0
	player.magica = 0
	player.sabedoria = 0
	player.inteligencia = 0
	player.ethrium = 0
	player.pontos = 5
	get_node("player").set_position(mapatual[mapa_index].start)
	get_parent().get_node("Spawn").set_wait_time()
	pass

# carrega o ultimo game em que o personagem saiu do jogo utilizando o menu
func carregar_jogo_salvo():
	update()
	player.pos = Vector2(player.pos_x,player.pos_y)
	add_child(mapatual[0])
	add_child(player)
	player.set_position(player.pos)
	camera_control()
	pass
	
func add_xp():
	player.xp += valor_base
	print(player.xp)
	pass
	
func change_map(mapa_index,new_map):
	remove_child(mapatual[mapa_index])
	add_child(mapatual[new_map])
	player.set_position(mapatual[new_map].start)
	pass
	
	
func save():
	db.open_db("res://db/player.sql")
	update()
	atualizar_skill()
	db.close()
	pass

func load_game():
	db.open_db("res://db/player.sql")
	get_db_player_status()
	carregar_jogo_salvo()
	load_skill_level()
	camera_control()
	db.close()
	pass

func update():
	var p_pos = player.get_position()
	var query = "UPDATE status "
	query += "set pontos = "+ str(player.pontos)
	query += ", skill_p = "+ str(player.pontos_skill)
	query += ", mag = "+ str(player.magica)
	query += ", sab = "+ str(player.sabedoria)
	query += ", int = "+ str(player.inteligencia)
	query += ", eth = "+ str(player.ethrium)
	query += ", pos_x = "+ str(p_pos.x)
	query += ", pos_y = "+ str(p_pos.y)
	query += ", xp = "+ str(player.xp)
	query += ", nivel =" + str(player.nivel)
	query += ", nome = "+"'" + str(new_name_player) +"' "
	query += " WHERE id = " + str(save_id) + ";"
	db.query(query)
	print(query)
	pass


func get_db_player_status():
	#select das informações do banco de dados
	var att = db.fetch_array("SELECT * FROM status WHERE id = " + str(save_id) + ";")
	player.pontos = int(att[(0)][("pontos")])
	player.pontos_skill = int(att[(0)][("skill_p")])
	player.magica = int(att[(0)][("mag")])
	player.sabedoria = int(att[(0)][("sab")])
	player.inteligencia = int(att[(0)][("int")])
	player.ethrium = int(att[(0)][("eth")])
	player.pos_x = int(att[(0)][("pos_x")])
	player.pos_y = int(att[(0)][("pos_y")])
	player.xp = int(att[(0)][("xp")])
	player.nivel = int(att[(0)][("nivel")])
	player._name = int(att[(0)][("nome")])
	print("pontos atualizados")
	pass

func atualizar_skill():
	var skill = "UPDATE skill "
	skill += "set frost_nivel = "+ str(player.frost["nivel"])
	skill += " WHERE id = " + str(save_id) + ";"
	print(skill)
	pass
	
func load_skill_level():
	var att
	att = db.fetch_array("SELECT frost_nivel FROM skill WHERE id = " + str(save_id) + ";")
	player.frost["nivel"] = int(att[(0)][("frost_nivel")])
	pass
	
func _on_save_automatico_timeout():
	update()
	print("_--!!!AUTO SAVE!!!--_")
	pass 