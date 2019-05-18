extends Node2D

var skill_damage = 0

#Animação
onready var anim = $speels

#AreaEffect
onready var area_effect = $fire/area

#timer_speel
onready var time_to_finish = $when_speel_anim_finish

func _ready():
	if get_parent().get_node("player").skill_set == "frost_cost":
		anim.set_frame(0)
		anim.set_animation("frost")
	elif get_parent().get_node("player").skill_set == "fire_cost":
		anim.set_animation("fire4")
	anim.play()
	
	pass
	
func cast_speel(speel_level,speel_time,speel_demage,speel_effect):
	anim.set_animation("fire"+"speel_level")
	anim.play()
	time_to_finish.set_wait_time(speel_time)
	pass

func _on_when_speel_anim_finish_timeout():
	pass


func _on_speels_animation_finished():
	queue_free()
	pass # replace with function body


func _on_fire_body_entered(body):
	print(body.get_parent().get_name())
	if body.get_parent().get_name() == "bau":
		if body.get_parent().has_method("abrir"):
			body.get_parent().abrir(25)
	if body.has_method("damage") and body.get_name() != "player":
		body.damage(skill_damage)
	pass # replace with function body
