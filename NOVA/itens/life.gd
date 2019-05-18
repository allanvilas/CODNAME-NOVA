extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func c_vida(body):
	if body.vida >= body.vida_max:
		body.vida = body.vida_max
	pass

func area(body):
	print(body.get_name())
	if body.get_name() == "player":
		if body.vida <= body.vida_max:
			print("sua vida atual: "+str(body.vida))
			body.vida += (body.vida_max/100 * 12)
			print("você recuperou vida: "+str(body.vida))
			if body.vida >= body.vida_max:
				body.vida = body.vida_max
				queue_free()
				pass
			queue_free()	
			#return c_vida(body)
			#queue_free()
			pass
	pass # Replace with function body.
