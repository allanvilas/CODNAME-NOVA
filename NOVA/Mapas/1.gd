extends TileMap

onready var start = $start.get_position()
onready var cena = get_parent()
export var mapa_index = 1

func _ready():
	cena.mapa_index = mapa_index
	pass