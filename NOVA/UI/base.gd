extends NinePatchRect

onready var highscore

onready var tempo_jogado = $higscore/tempo
onready var total_dano_causado = $higscore/dano_total_causado
onready var total_dano_recebido = $higscore/dano_total_recebido
onready var xp_total = $higscore/xp_total
onready var inimigos_mortos = $higscore/inimigos_derrotados
onready var level_maximo = $higscore/level_maximo

func _ready():
	var root = get_tree().get_nodes_in_group("root")
	for i in root.size():
		if root[i].get_name() == "highscore":
			highscore = root[i]
			pass
	pass 
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_update_timeout():
	#definir tempo ainda
	total_dano_causado.set_text("Dano Causado: " + str(highscore.total_dano_causado))
	total_dano_recebido.set_text("Dano Recebido: " + str(highscore.total_dano_recebido))
	xp_total.set_text("Xp Total: "+str(highscore.xp_total))
	inimigos_mortos.set_text("Inimigos Mortos: "+str(highscore.inimigos_mortos))
	level_maximo.set_text("Level Maximo: "+str(highscore.level_maximo))
	pass
