extends AnimatedSprite

onready var player
onready var gate = self
onready var collision = $body/colli

##gate state
# false = close
# true = open
export var gate_state = false

func _ready():
	pass 

func interact():
	if gate_state == true:
		gate.play_animation("open")
		collision.set_disabled(true)
		pass
	elif gate_state == false:
		gate.play_animation("close")
		collision.set_disabled(false)
		pass
	else:
		gate.play_animation("close")
		collision.set_disabled(false)
		pass
	pass

func _on_up_body_entered(body):
	self.player = body
	pass 

func _on_down_body_entered(body):
	self.player = body
	pass 