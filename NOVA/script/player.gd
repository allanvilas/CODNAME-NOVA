extends KinematicBody2D

onready var speel = preload("res://cenas/speel.tscn")

onready var cena = get_parent()

#Status
var magica = 2
var sabedoria = 5
var inteligencia = 3
var ethrium = 5

#keys
var keys = {brass=0,iron=0,gold=0,diamond=0}

var obj_interact 
#pos
var pos = Vector2(0,0)
var pos_x = 0.0
var pos_y = 0.0

var _name = ""
var vida = 100
var vida_max = 100
var mana = 50
var mana_max = 50
var xp = 0
var xp_to_up = 50
var nivel = 10
var pontos = 5
var pontos_skill = 1
#skillset
#1 frost
#2 fire
var skill_set = null

#Movimento
var move = Vector2(0,0)
export var velocidade = 1.3

#Animação
onready var anim = $mage

#Cast
var casting = false
var can_attack = true

var cell_vs_magnitude = []

func _ready():
	#player [0]
	var cast = get_tree().get_nodes_in_group("cast")
	
	var ui = get_parent().get_parent().get_parent().get_node("/root/ui")
	ui.get_node("status").player = self
	ui.player = self
	ui.status_update()
	pass
	
func calculate_points():
	for i in cena.cell_position.size():
		cell_vs_magnitude.resize(cena.cell_position.size())
		#print(cell_vs_magnitude.size())
		var celula_alvo = cena.cell_position[i]
		var posicao_player = get_position()
		var magnitude = celula_alvo - posicao_player
		var h = (sqrt(magnitude.x * magnitude.x + magnitude.y * magnitude.y) - 16)
		cell_vs_magnitude[i] = floor(h)
		cena.cell_magnitude = cell_vs_magnitude
		#print(cena.cell_magnitude)
		pass
	pass
	
func self_update_pos():
	pos = get_position()
	pos_x = pos.x
	pos_y = pos.y
	pass

func self_light_intensity():
	var vida_lerp = inverse_lerp(0,vida_max,vida)
	var l_weight = lerp(0.2,1,vida_lerp)
	$Light2D.set_texture_scale(l_weight)
	pass
	
func _physics_process(delta):
	self_light_intensity()
	self_update_pos()
	ui.status_update()
	var move_up = Input.is_action_pressed("up")
	var move_down = Input.is_action_pressed("down")
	var move_left = Input.is_action_pressed("left")
	var move_right = Input.is_action_pressed("right")
	var cast = Input.is_action_just_pressed("cast")
	var interact = Input.is_action_just_pressed("interact")
	
	if obj_interact != null && obj_interact.has_method("interact"):
		if interact:
			print("interagindo")
			obj_interact.interact()
			pass
	else:
		#print("sem objeto")
		pass
	
	var teste = Input.is_action_just_pressed("db")
	
	if casting == false and can_attack == true:
		if move_up:
			move = Vector2(0,0)
			move.y -= 1
			anim.set_animation("walk")
		elif move_down:
			move = Vector2(0,0)
			move.y += 1
			anim.set_animation("walk")
		elif move_left:
			move = Vector2(0,0)
			move.x -= 1
			anim.set_animation("walk")
		elif move_right:
			move = Vector2(0,0)
			move.x += 1
			anim.set_animation("walk")
		else:
			move = Vector2(0,0)
			anim.set_animation("idle")	
			
		if cast and can_attack == true and skill_set != null:
			#print(skill_set)
			if mana >= get_node("skills").skill[skill_set]["custo"] and skill_set != null:
				casting = true
				anim.set_animation("cast")
				anim.play()
				move = Vector2(0,0)
				var spel = load("res://cenas/speel.tscn").instance()
				spel.player_set_skill = skill_set
				spel.skill = get_node("skills")
				cast_speel(spel)
				mana -= spel.skil_set["custo"]
				if mana <= mana_max:
					$mana_recover.start()
			else:
				#print("____----''''Sem mana!!!''''----____")
				pass
	move_and_collide(move * velocidade)	
	pass

func cast_speel(spel):
	get_parent().add_child(spel)
	spel.set_position(get_global_mouse_position())
	pass

#func _on_mage_animation_finished():
	#casting = false
	#pass # replace with function body

func _on_mage_animation_finished():
	casting = false
	pass # replace with function body

func damage(dano):
	vida -= dano
	if vida <= 0:
		get_parent().get_parent().get_node("highscore").update_highscore()
		get_tree().quit()
		pass
	pass

func _on_mana_recover_timeout():
	if mana <= mana_max:
		mana += 1
	else:
		$mana_recover.stop()
	pass 
func _on_cell_vs_magnitude_timeout():
	calculate_points()
	#xp+=15
	pass 

func obj_entered(body_id, body, body_shape, area_shape):
	obj_interact = body.get_parent()
	obj_interact.player = self
	print(body.get_parent().get_name())
	pass

func obj_exited(body_id, body, body_shape, area_shape):
	obj_interact = null
	pass 
