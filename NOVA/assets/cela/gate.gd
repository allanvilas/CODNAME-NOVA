extends AnimatedSprite
var root
onready var player
onready var gate = self
onready var collision = $body/colli

##gate state
# false = close
# true = open
export var gate_state = false
export var key = ""
export var gate_name = ""

func _ready():
	root = get_tree().get_nodes_in_group("root")
	for i in root.size():
		if root[i].get_name() == "player":
			player = root[i]
			pass
		pass
	gate()
	pass 

func interact():
	if player != null:
		for i in player.keys.size():
			if player.keys[i] == key:
				gate_state == true
				print("Player have the key")
				gate()
				pass
			else:
				print("Você não tem a chave para acessar " + gate_name + ", retorne com a chave correta!")
				pass
		pass

func gate():
	if gate_state == true:
		gate.play("open")
		collision.set_disabled(true)
		pass
	elif gate_state == false:
		gate.play("close")
		collision.set_disabled(false)
		pass
	else:
		gate.play_animation("close")
		collision.set_disabled(false)
		pass
	pass