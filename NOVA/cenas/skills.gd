extends Node2D

var mod_mag = 0
var mod_int = 0
var mod_sab = 0
var mod_eth = 0

var skill = {
	'skill_1':{
		nome="Frost",
		mod_dmg=0.10,
		dmg_index= 0.10,
		mod_cost=0.1,
		cost_index=0.10,
		min_level=0,
		learned=false,
		sprite="res://assets/speels/frost/frostskill5.png",
		custo_base=15,
		level=1,
		dano_base=5,
		custo= 0,
		dano= 0,
		},
	'skill_2':{
		mod_dmg=0.20,
		dmg_index=0.20,
		mod_cost=0.2,
		cost_index=0.2,
		min_level=3,
		learned=false,
		sprite="res://assets/speels/fire/fire3.png",
		nome="Fire",
		custo_base=25,
		custo= 0,
		dano_base=15,
		dano= 0,
		level=1,
	},
	'skill_3':{
		mod_dmg=0.30,
		dmg_index= 1,
		mod_cost=0.20,
		cost_index=0.3,
		min_level=5,
		learned=false,
		sprite="res://assets/speels/explosion/explosion4.png",
		nome="Blast",
		custo_base=35,
		custo= 0,
		dano_base=20,
		dano= 0,
		level=1,
	},
	}
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
