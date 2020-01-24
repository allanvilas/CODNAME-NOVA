extends Node2D

onready var light = $key/Light2D
onready var sprite = $key
onready var anim = $anim

export var light_colors = PoolColorArray([
	Color(91.0,55.0,13.0,1.0),
	Color(90.0,90.0,100.0,1.0),
	Color(220.0,185.0,90.0,1.0),
	Color(90.0,220.0,200.0,1.0)
	])
					
var keys_sprites = {
	brass="res://assets/keys/key_brass.png",
	iron="res://assets/keys/key_iron.png",
	gold="res://assets/keys/key_gold.png",
	diamond="res://assets/keys/key_diamond.png",}
	
var texture

var key_names = [
	"brass",
	"iron",
	"gold",
	"diamond"]

enum keys {brass,iron,gold,diamond}

export(keys) var key

func _ready():
	anim.play()
	set_key_color_and_sprite()
	pass

func set_key_color_and_sprite():
	texture = load(keys_sprites[key_names[key]])
	sprite.set_texture(texture)
	light.set_color(light_colors[(key)])
	print(light_colors[(key)])
	pass
	
func pickup(body):
	if body.keys != null:
		body.keys[str(key_names[key])] += 1
		queue_free()
		pass
	pass 