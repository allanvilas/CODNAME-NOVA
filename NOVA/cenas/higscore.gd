extends Node2D

onready var tempo_jogado = {segundos = 0, minutos = 0, horas = 0, dias = 0}
onready var total_dano_causado = 0
onready var total_dano_recebido =0
onready var xp_total =0
onready var inimigos_mortos =0
onready var level_maximo =0

func _ready():
	
	pass

func tempo():
	if get_parent().get_node("Cena"):
		level_maximo = get_parent().get_node("Cena").player.nivel
	time_played()
	pass
	
func time_played():
	tempo_jogado["segundos"] =+ 1
	if tempo_jogado["segundos"] >= 60:
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