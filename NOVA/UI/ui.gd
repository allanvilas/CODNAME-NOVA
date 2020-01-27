extends CanvasLayer
var db
var menu
var player
onready var mana = $needs/mana/mana
onready var vida = $needs/vida
onready var xp_pontos = $status/base/player/xp
onready var xp = $status/base/player/exp
onready var nivel = $status/base/player/lv
onready var player_name = $status/base/player/PLayer
onready var pontos = $status/base/acc/pontos_atual
onready var qt_mana = $needs/mana/mana/qt_mana

func _ready():
	get_node("status").set_visible(false)
	pass
	
func status_update():
	$status.up_skills()
	$status.atualizar_valores()
	
	vida.set_max(player.vida_max)
	mana.set_max(player.mana_max)
	xp.set_max(player.xp_to_up)
	
	vida.set_value(player.vida)
	mana.set_value(player.mana)
	xp.set_value(player.xp)
	
	nivel.set_text("Lv." + str(player.nivel))
	qt_mana.set_text(str(player.mana))
	xp_pontos.set_text(str(player.xp))
	pontos.set_text(str(player.pontos))
	
	if Input.is_action_just_pressed("1"):
		print("um")
		if player.get_node("skills").skill["skill_1"]["learned"] == true:
			player.skill_set = "skill_1"
			btn_status(false,true,false)
			get_node("skills/skill_1").set_disabled(false)
		else:
			get_node("skills/skill_1").set_disabled(true)
			pass
		pass
	elif Input.is_action_just_pressed("2"):
		print("dois")
		if player.get_node("skills").skill["skill_2"]["learned"] == true:
			player.skill_set = "skill_2"
			btn_status(false,true,false)
			get_node("skills/skill_2").set_disabled(false)
		else:
			get_node("skills/skill_2").set_disabled(true)
			pass
		pass
	elif Input.is_action_just_pressed("3"):
		print("três")
		if player.get_node("skills").skill["skill_3"]["learned"] == true:
			player.skill_set = "skill_3"
			btn_status(false,false,true)
			get_node("skills/skill_3").set_disabled(false)
		else:
			get_node("skills/skill_3").set_disabled(true)
			pass
		pass
	# menu status
	if Input.is_action_just_pressed("status"):
		if player.can_attack == true:
			get_node("status").set_visible(true)
			player.can_attack = false
		else:
			player.can_attack = true
			get_node("status").set_visible(false)
			
	#menu principal
	if Input.is_action_just_pressed("menu"):
		if player.can_attack == true:
			menu.set_visible(true)
			player.can_attack = false
		else:
			player.can_attack = true
			menu.set_visible(false)
		
	#cost
	#print(player.spells[frost_cost])
	#$skills/frost/cost.set_text(str(player.spells["frost_cost"]))
	
	#$skills/fire/cost.set_text(str(player.spells["fire_cost"]))	
	level_up()
	pass
	
func level_up():
	if player.xp >= player.xp_to_up:
		player.xp = player.xp - player.xp_to_up
		player.nivel += 1
		player.pontos += 5
		player.pontos_skill += 1
		player.xp_to_up += randi()% 50
		print("XP atual" + str(player.xp))
		print("xp para upar" + str(player.xp_to_up))
	pass

func _on_esc_pressed():
	pass # replace with function body
	
#skills
onready var skills = [
		get_node("skills/skill_1"),
		get_node("skills/skill_2"),
		get_node("skills/skill_3"),
		]
var btn_st = [false,false,false]

func btn_status(A,B,C):
	btn_st = [A,B,C]
	skills[0].set_pressed(A)
	skills[1].set_pressed(B)
	skills[2].set_pressed(C)
	pass

func skill_1(button_pressed):
	if not skills[0].is_disabled():
		btn_status(true,false,false)
		player.skill_set = "skill_1"
	pass

func skill_2(button_pressed):
	if not skills[1].is_disabled():
		btn_status(false,true,false)
		player.skill_set = "skill_2"
	pass

func skill_3(button_pressed):
	if not skills[2].is_disabled():
		btn_status(false,false,true)
		player.skill_set = "skill_3"
	pass