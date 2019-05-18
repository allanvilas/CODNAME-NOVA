extends Node2D
var rato = preload("res://assets/inimigo/rato/00012.tscn").instance()

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	get_node("cena").add_child()
	pass

func _process(delta):



	pass

func spawn_enemyes():
	var rato = preload("res://assets/inimigo/rato/00012.tscn").instance()
	get_node("cena").add_child()
	pass