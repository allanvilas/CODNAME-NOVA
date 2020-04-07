extends Node2D

onready var tempo_jogado = [0,0,0,0]
onready var total_dano_causado = 0
onready var total_dano_recebido = 0
onready var xp_total = 0
onready var inimigos_mortos = 0
onready var level_maximo = 0

onready var cena = get_parent().get_node("Cena")
onready var db = cena.db

var query

var segundos = 0
var minutos = 0
var horas = 0
var dias = 0

func _ready():
	pass
	
func fetch_highscore():
	var atributos = db.fetch_array("SELECT * FROM HIGHSCORE WHERE nome = " + "'" +str(cena.player._name) + "' " + ";")
	print("Atributos: "+ str(atributos))
	cena.new_name_player = str(atributos[(0)][("nome")])
	self.tempo_jogado = int(atributos[(0)][("tempo")])
	self.total_dano_causado = int(atributos[(0)][("dano_causado")])
	self.total_dano_recebido = int(atributos[(0)][("dano_recebido")])
	self.xp_total = int(atributos[(0)][("xp_total")])
	self.inimigos_mortos = int(atributos[(0)][("inimigos_mortos")])
	self.level_maximo = int(atributos[(0)][("level_maximo")])
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
	db.query(query)
	pass
	
func tempo():
	if cena:
		level_maximo = cena.player.nivel
	time_played()
	pass
	
func time_played():
	#print("segundos: "+str(segundos)+"  Minutos:  "+str(minutos)+"  Horas: "+str(horas)+"  Dias: "+str(dias) )
	if segundos < 60:
		segundos += 30
		pass
		if segundos == 60:
			minutos += 1
			segundos = 0
			pass
	if minutos == 60:
		horas += 1
		minutos = 0
		pass
	if horas == 24:
		dias +=1
		horas = 0
		pass
			
	#tempo_jogado[0] += 1
	#if tempo_jogado[0] >= 60:
		#update_highscore()
		#tempo_jogado[0] = 0
		#tempo_jogado[1] += 1
		#pass
	#if 	tempo_jogado[1] >= 60:
		#tempo_jogado[1] = 0
	#	tempo_jogado[2] += 1
#		pass
	#if 	tempo_jogado[2] >= 24:
	#	tempo_jogado[2] = 0
	#	tempo_jogado[3] += 1
	#	pass
	pass
