extends Control

onready var pop = get_parent().get_node("PopupDialog")
onready var player
func _ready():
	pass


func atualizar_valores():
	$base/magica/value.set_text(str(player.magica))
	$base/sab/value.set_text(str(player.sabedoria))
	$base/int/value.set_text(str(player.inteligencia))
	$base/eth/value.set_text(str(player.ethrium))
	#$skills/frost/nivel.set_text("Nivel:" + str(player.frost["nivel"]))
	#var dano_base = int(player.frost["base"])+(int(player.frost["nivel"] * 5))
	#$skills/frost/dano.set_text("Dano:" + str(dano_base + ((dano_base*0.01) * player.magica)))
	#player.frost["dano"] = int($skills/frost/dano.get_text())
func _on_esc_pressed():
	self.set_visible(false)
	get_parent().player.can_attack = true
	pass 

func _on_mag2_pressed():
	up_skills()
	if player.pontos > 0:
		player.pontos -= 1
		player.magica += 1
		player.mana = round(player.mana_max * 1.1)
		player.get_node("skills").skill["skill_1"]["dano_base"] = round(player.get_node("skills").skill["skill_1"]["dano_base"] *1.1)
		player.get_node("skills").skill["skill_2"]["dano_base"] = round(player.get_node("skills").skill["skill_2"]["dano_base"] *1.1)
		player.get_node("skills").skill["skill_3"]["dano_base"] = round(player.get_node("skills").skill["skill_3"]["dano_base"] *1.1)
	else:
		print("pontos insuficientes")
	pass 

func _on_sabe_pressed():
	up_skills()
	if player.pontos > 0:
		player.pontos -= 1
		player.sabedoria += 1
	else:
		print("pontos insuficientes")
	pass # replace with function body

func _on_inte_pressed():
	up_skills()
	if player.pontos > 0:
		player.pontos -= 1
		player.inteligencia += 1
	else:
		print("pontos insuficientes")
	pass # replace with function body

func _on_ethri_pressed():
	up_skills()
	if player.pontos > 0:
		player.pontos -= 1
		player.ethrium += 1
	else:
		print("pontos insuficientes")
	pass # replace with function body

func _on_accept_pressed():
	pass # replace with function body

### troca de menûs
func _on_base_pressed():
	$base.set_visible(true)
	$status.set_visible(false)
	$skills.set_visible(false)
	pass # replace with function body

func _on_status_pressed():
	$base.set_visible(false)
	$skills.set_visible(false)
	$status.set_visible(true)
	pass # replace with function body

func _on_skills_pressed():
	$skills.set_visible(true)
	$status.set_visible(false)
	$base.set_visible(false)
	pass 

#botão add da skill frost
var player_skill_dict
func up_skill(index):
	self.player_skill_dict = player.get_node("skills").skill
	var psd = player_skill_dict["skill_"+str(index)]
	print("teste")
	
	
	if player.pontos_skill >=1:
		if player.nivel <= psd["min_level"]:
			pop.popup()
			pop.get_node("TXT").set_text("Você não tem level suficiente, volte quando alcançar o level "+str(psd["min_level"]))
			print("Você não tem level suficiente, volte quando alcançar o level "+str(psd["min_level"]))
		else:
			psd["level"] += 1
			#upar skill sem gastar pontos, teste
			#player.pontos_skill -=1
			psd["learned"] = true
			pop.popup()
			pop.get_node("TXT").set_text("Você evoluiu a skill "+str(psd["nome"]))
			psd["mod_dmg"] += psd["dmg_index"]
			psd["mod_cost"] += psd["cost_index"]
			att_skill_dmg(psd)
			#psd["dano"] = psd["dano_base"] +( psd["dano_base"] * psd["mod_dmg"] )
			#psd["custo"] = psd["custo_base"] +( psd["custo_base"] * psd["mod_cost"] )
			print(psd)
			pass
	else:
		pop.popup()
		pop.get_node("TXT").set_text("Você não tem pontos disponíveis!")
		pass
		
	if psd["learned"]:
		if not skills_learned.has(psd):
			skills_learned.append(psd)
		pass
	up_skills()	
	pass
func att_skill_dmg(psd):
	psd["dano"] = psd["dano_base"] +( psd["dano_base"] * psd["mod_dmg"] )
	psd["custo"] = psd["custo_base"] +( psd["custo_base"] * psd["mod_cost"] )
	pass
var skills_learned = []

func add_skill_1():
	up_skill(1)
	pass

func add_skill_2():
	up_skill(2)
	pass 

func add_skill_3():
	up_skill(3)
	pass 
	
func up_skills():
	self.player_skill_dict = player.get_node("skills").skill
	var num = self.skills_learned
	print(skills_learned)
	var cont = 0
	var index = num.size()
	for i in num.size():
		print(i)
		cont = i+1
		var skill = num[i]
		att_skill_dmg(num[i])
		var sprite = load(skill["sprite"])
		get_node("skills/skill_"+str(cont)+"/tex").set_texture(sprite)
		get_parent().get_node("skills/skill_"+str(cont)+"/skill_tex").set_texture(sprite)
		get_parent().get_node("skills/skill_"+str(cont)+"/skill_tex/cost").set_visible(true)
		get_parent().get_node("skills/skill_"+str(cont)+"/skill_tex/cost").set_text(str(skill["custo"]))
		get_node("skills/skill_"+str(cont)+"/name").set_text(skill["nome"])
		get_node("skills/skill_"+str(cont)+"/dano").set_text("Dano: "+str(skill["dano"]))
		get_node("skills/skill_"+str(cont)+"/nivel").set_text("Level: "+str(skill["level"]))
		pass
	pass
	

func _on_PopupDialog_about_to_show():
	pass 


func _on_PopupDialog_popup_hide():
	pass # Replace with function body.
