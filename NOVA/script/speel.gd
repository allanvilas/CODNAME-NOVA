extends Node2D

onready var skill_1 = preload("res://assets/speels/frost/frostskill5.png")
onready var skill_2 = preload("res://assets/speels/fire/fire2.png")
onready var skill_3 = preload("res://assets/speels/explosion/explosion3.png")
onready var skill 

func _init():
	
	pass
onready var player_set_skill 	
onready var skil_set = skill["skill"][player_set_skill]
onready var skill_damage = skil_set["dano"]
#Animação
onready var anim = $speels

#AreaEffect
onready var area_effect = $fire/area

#timer_speel
onready var time_to_finish = $when_speel_anim_finish

func _ready():
	print("!!!Teste: "+str(skill))
	print("!!!Teste: "+str(skill))
	#assim que a skill sofre a instance()
	print(skil_set["nome"])
	if skil_set["learned"] == true:
		anim.set_animation(skil_set["nome"])
		anim.set_frame(0)
		anim.play()
		return
	
	pass

func _on_speels_animation_finished():
	queue_free()
	pass # replace with function body

func _on_fire_body_entered(body):
	#print(body.get_parent().get_name())
	if skil_set["learned"]:
		if body.has_method("damage") and body.get_name() != "player":
			body.damage(skill_damage)
	pass # replace with function body