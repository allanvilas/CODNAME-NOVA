extends AnimatedSprite

onready var player
onready var gate = self
onready var collision = $body/colli

##gate state
# false = close
# true = open
export var gate_state = false

var gate_name

var key_names = ["brass","iron","gold","diamond"]

enum kays {brass,iron,gold,diamond}

export(kays) var _kay

func _ready():
	gate()
	pass 

func interact():
	if player != null:
		if player.keys[key_names[_kay]] > 0:
			gate_state = true
			print("Player have the key")
			gate()
			player.keys[key_names[_kay]] -= 1
			print("Você tem " + str(player.keys[key_names[_kay]]) + " " + key_names[_kay] )
		pass
	else:
		print("Você não tem a chave para acessar " + gate_name + ", retorne com a chave correta!")
		pass
	pass

func gate():
	
	gate_name = key_names[_kay]
	
	if gate_state == true:
		print("OPEN THE GATE")
		gate.play("open")
		pass
	if gate_state == false:
		gate.play("close")
		print("CLOSE THE GATE")
		pass
	pass

func _on_gate_animation_finished():
	if gate_state == true:
		gate.stop()
		gate.set_frame(4)
		collision.set_disabled(true)
		pass
	if gate_state == false:
		gate.stop()
		gate.set_frame(4)
		collision.set_disabled(false)
		pass
	pass