extends TileMap

onready var spawn 

onready var used_cells = []

onready var root 

func _ready():
	used_cells = get_used_cells()
	root = get_tree().get_nodes_in_group("root")
	for i in root.size():
		if root[i].get_name() == "Spawn":
			print("nó spawn foi encontrado em root e definido em icon")
			spawn = root[i]
			pass
		pass
	if spawn != null:
		for i in used_cells.size():
			var cell_used = used_cells[i]
			spawn.cell_position.append(map_to_world(cell_used,false))
			print("Posição de spawn de inimigos"+str(spawn.cell_position))
			pass
	pass