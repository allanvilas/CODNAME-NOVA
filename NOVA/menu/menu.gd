extends CanvasLayer

onready var cena = get_parent()

#estado do name select.
var estado 

var random_placeholder = ["Make Your Choice!","The Champion!!",
						 "Masterfull","Wellcome","Lerrrrrroyyy!!",
						 "Holly S#@%&!!","Bastard's Killer!","Monsterkill",
						 "Brave New World!","Seventh Son of Senventh Son","1337","This is an Placeholder"]

func _ready():
	$base/degra.set_visible(true)
	$base/name.set_visible(false)
	$base/degra/base2/load/base4.set_visible(false)
	$base/degra/base2/op/base3.set_visible(false)
	var ui = get_parent().get_parent().get_parent().get_node("/root/ui")
	ui.menu = get_node("base")
	# Called when the node is added to the scene for the first time.
	# Initialization here
	get_parent().get_node("save_automatico").set_wait_time(300)
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

# novo jogo

var new_player_name 

func random_places():
	var A
	var B = random_placeholder.size() + 1
	var C = randi()%B
	for i in B:
		C = randi()%B
		
	A = random_placeholder[C]
	return A
	pass
	
func _on_novo_jogo_pressed():
	get_node("base/degra").set_visible(false)
	get_node("base/name/back/form/new_name").set_placeholder(str(random_places()))
	get_node("base/name").set_visible(true)
	pass 

func new_name(new_player_name):
	self.new_player_name = new_player_name
	cena.new_name_player = new_player_name
	estado = 1
	$wait.set_wait_time(2)
	$wait.start()
	pass

func _on_wait_timeout():
	if estado == 1:
		$wait.stop()
		$base/name/back/form.set_visible(false)
		$base/name/back/welcome.set_visible(true)
		estado = 2
		$wait.start()
	elif estado == 2:
		$base/name/back/new_name.set_text(new_player_name)
		$base/name/back/new_name.set_visible(true)
		estado = 3
		$wait.start()
		pass
	elif estado == 3:
		get_node("base").set_visible(false)
		$base/name.set_visible(false)
		get_parent().novo_jogo()
		print(new_player_name)
		print(cena.new_name_player)
		get_node("base/degra").set_visible(true)
		$wait.stop()
	pass 

func return_new():
	get_node("base/name").set_visible(false)
	get_node("base/degra").set_visible(true)
	pass 
	
#---------------------------

func _on_sair_pressed():
	get_tree().quit()
	pass

func _on_load_pressed():
	$base/degra/base2/load/base4.set_visible(true)
	pass
	
func _on_fechar_load_pressed():
	$base/degra/base2/load/base4.set_visible(false)
	pass # replace with function body

func _on_op_pressed():
	$base/degra/base2/op/base3.set_visible(true)
	$base/degra/base2/load.set_visible(false)
	pass 

# MENU OPÇÕES
func _on_CheckButton_toggled(button_pressed):
	if button_pressed == true:
		get_parent().get_node("save_automatico").start()
		print(button_pressed)
	else:
		get_parent().get_node("save_automatico").stop()	
	pass 

##botão fechar do menu opções
func _on_TextureButton_pressed():
	$base/degra/base2/op/base3.set_visible(false)
	$base/degra/base2/load.set_visible(true)
	pass

func _on_300sg_toggled(button_pressed):
	if button_pressed == true:
		get_parent().get_node("save_automatico").set_wait_time(300)
		get_node("base/degra/base2/op/base3/600sg").set_pressed(false)
		print(get_parent().get_node("save_automatico").get_wait_time())
	else:
		get_node("base/degra/base2/op/base3/300sg").set_pressed(true)
		pass
	pass 

func _on_600sg_toggled(button_pressed):
	
	if button_pressed == true:
		get_parent().get_node("save_automatico").set_wait_time(600)
		get_node("base/degra/base2/op/base3/300sg").set_pressed(false)
		print(get_parent().get_node("save_automatico").get_wait_time())
	else:
		get_node("base/degra/base2/op/base3/600sg").set_pressed(true)
	pass 

#primeiro slot de load
func _on_load1_pressed():
	#get_parent().open_database()
	get_node("base").set_visible(false)
	get_parent().save_id = 1
	get_parent().load_game()
	#get_parent().db.close()
	pass # replace with function body	

func _on_load2_pressed():
	#get_parent().open_database()
	get_node("base").set_visible(false)
	get_parent().save_id = 2
	get_parent().load_game()
	#get_parent().db.close()
	pass # replace with function body


func _on_load3_pressed():
	#get_parent().open_database()
	get_node("base").set_visible(false)
	get_parent().save_id = 3
	get_parent().load_game()
	#get_parent().db.close()
	pass # replace with function body


func _on_save1_pressed():
	#get_parent().open_database()
	get_node("base").set_visible(false)
	get_parent().save_id = 1
	get_parent().save()
	#get_parent().db.close()
	pass # replace with function body


func _on_save2_pressed():
	#get_parent().open_database()
	get_node("base").set_visible(false)
	get_parent().save_id = 2
	get_parent().save()
	#get_parent().db.close()
	pass # replace with function body


func _on_save3_pressed():
	#get_parent().open_database()
	get_node("base").set_visible(false)
	get_parent().save_id = 3
	get_parent().save()
	#get_parent().db.close()
	pass # replace with function body
