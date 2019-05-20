extends Node2D

onready var tempo_jogado = {segundos = 0, minutos = 0, horas = 0, dias = 0}
onready var total_dano_causado = 0
onready var total_dano_recebido = 0
onready var xp_total = 0
onready var inimigos_mortos = 0
onready var level_maximo = 0

onready var cena = get_parent().get_node("Cena")
onready var db = cena.db

var query

func _ready():
	pass
	
func fetch_highscore():
	db.close()
	db.open_db("res://db/player.sql")
	var atributos = db.fetch_array("SELECT * FROM HIGHSCORE WHERE nome = " + "'" +str(cena.player._name) + "'" + ";")
	cena.new_name_player = str(atributos[(0)][("nome")])
	self.tempo_jogado = int(atributos[(0)][("tempo")])
	self.total_dano_causado = int(atributos[(0)][("dano_causado")])
	self.total_dano_recebido = int(atributos[(0)][("dano_recebido")])
	self.xp_total = int(atributos[(0)][("xp_total")])
	self.inimigos_mortos = int(atributos[(0)][("inimigos_mortos")])
	self.level_maximo = int(atributos[(0)][("level_maximo")])
	db.close()
	pass

func create_higscore():
	db.open_db("res://db/player.sql")
	var query = "INSERT INTO highscore (nome,tempo,dano_causado,dano_recebido,xp_total,inimigos_mortos,level_maximo)"
	query += " values ("
	query += "'"+str(cena.player._name)+"'" + ","
	query += "'"+str(tempo_jogado)+"'" + ","
	query += str(total_dano_causado) + ","
	query += str(total_dano_recebido) + ","
	query += str(xp_total) + ","
	query += str(inimigos_mortos) + ","
	query += str(level_maximo)
	query += ")"
	db.query(query)
	print(query)
	db.close()
	pass
	
func update_highscore():
	var query = "UPDATE highscore set"
	query += " nome = " + "'"+str(cena.player._name)+"'" + ","
	query += " tempo = " + "'"+str(tempo_jogado)+"'" + ","
	query += " dano_causado = " + str(total_dano_causado) + ","
	query += " dano_recebido = " + str(total_dano_recebido) + ","
	query += " xp_total = " + str(xp_total) + ","
	query += " inimigos_mortos = " + str(inimigos_mortos) + ","
	query += " level_maximo = " + str(level_maximo)
	query += " WHERE nome LIKE " + "'"+str(cena.player._name)+"' " + ";"
	pass
	
func tempo():
	if cena:
		level_maximo = cena.player.nivel
	time_played()
	pass
	
func time_played():
	tempo_jogado["segundos"] += 1
	if tempo_jogado["segundos"] >= 60:
		update_highscore()
		tempo_jogado["segundos"] = 0
		tempo_jogado["minutos"] += 1
		pass
	if 	tempo_jogado["minutos"] >= 60:
		tempo_jogado["minutos"] = 0
		tempo_jogado["horas"] += 1
		pass
	if 	tempo_jogado["horas"] >= 24:
		tempo_jogado["horas"] = 0
		tempo_jogado["dias"] += 1
		pass
	pass