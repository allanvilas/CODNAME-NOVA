extends Control


var player

func _ready():
	pass

func atualizar_valores():
	$base/magica/value.set_text(str(player.magica))
	$base/sab/value.set_text(str(player.sabedoria))
	$base/int/value.set_text(str(player.inteligencia))
	$base/eth/value.set_text(str(player.ethrium))
	$skills/frost/nivel.set_text("Nivel:" + str(player.frost["nivel"]))
	var dano_base = int(player.frost["base"])+(int(player.frost["nivel"] * 5))
	$skills/frost/dano.set_text("Dano:" + str(dano_base + ((dano_base*0.01) * player.magica)))
	player.frost["dano"] = int($skills/frost/dano.get_text())
func _on_esc_pressed():
	self.set_visible(false)
	get_parent().player.can_attack = true
	pass 

func _on_mag2_pressed():
	if player.pontos > 0:
		player.pontos -= 1
		player.magica += 1
		
	else:
		print("pontos insuficientes")
	pass 

func _on_sabe_pressed():
	if player.pontos > 0:
		player.pontos -= 1
		player.sabedoria += 1
	else:
		print("pontos insuficientes")
	pass # replace with function body

func _on_inte_pressed():
	if player.pontos > 0:
		player.pontos -= 1
		player.inteligencia += 1
	else:
		print("pontos insuficientes")
	pass # replace with function body

func _on_ethri_pressed():
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
func _on_TextureButton_pressed():
	
	if player.pontos_skill > 0:
		player.frost["nivel"] += 1
		player.pontos_skill -= 1
		print(player.frost["nivel"])
	pass 
