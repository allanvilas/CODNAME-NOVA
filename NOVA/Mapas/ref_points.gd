extends TileMap

onready var cena = get_parent().get_parent()

onready var used_cells = []

func _ready():
	used_cells = get_used_cells()
	var i = 0
	for i in used_cells.size():
		var cell_used = used_cells[i]
		cena.cell_position.append(map_to_world(cell_used,false))
		print(cena.cell_position)
		i += 1
		pass
	pass