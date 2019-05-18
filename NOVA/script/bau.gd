extends Node2D

var vida = 100

onready var anim = $Sprite

var inativo = false
var can_open = false
onready var cena = get_parent().get_parent().get_parent()
export var map_to = 1

func _ready():
	
	pass
	
func abrir(dano):
	if inativo == false:
		vida -= dano
		if vida <= 0:
			anim.set_animation("aberto")
			inativo = true
	pass

func _on_Area2D_body_entered(body):
	if body.get_name() == "player":
		$AnimatedSprite.set_visible(true)
		can_open = true
		var atual_map = get_parent().get_parent().mapa_index	
		cena.change_map(atual_map,map_to)
	pass 

func _on_Area2D_body_exited(body):
	can_open = false
	$AnimatedSprite.set_visible(false)
	pass # replace with function body