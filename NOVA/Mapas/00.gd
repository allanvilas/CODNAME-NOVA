extends TileMap

onready var start = $start.get_position()
onready var cena = get_parent()
onready var ref_points = get_node("ref_points")
export var mapa_index = 0
var used_cells = []
func _ready():
	cena.mapa_index = mapa_index
	used_cells = ref_points.get_used_cells()
	#print(used_cells)
	cena.mapa_used_cells = used_cells
	pass