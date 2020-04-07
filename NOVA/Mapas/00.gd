extends TileMap

onready var start = $start.get_position()
onready var cena = get_parent()
onready var ref_points = get_node("ref_points")
export var mapa_index = 0
onready var luz = get_node("envirorment/luz")
var used_cells = []

#Astar
onready var astar = AStar.new()

onready var half_cell = cell_size / 2

onready var cell = get_used_cells()

onready var rect = get_used_rect()

func add_points(cell):
	
	for cell in cell:
		
		var id = make_id(cell)
		
		astar.add_point(id, Vector3(cell.x,cell.y,0))
		
		pass
	
	pass
func connect_points(cell):
	for cell in cell:
		
		var id = make_id(cell)
		
		for x in range(3):
			for y in range(3):
				
				var target = cell + Vector2(x-1, y-1)
				
				var target_id = make_id(target)
				
				if cell == target or not astar.has_point(target_id):
					continue
					astar.connect_points(id,target_id,true)
	pass
	
func make_id(point):
	
	var x = point.x - rect.position.x
	var y = point.y - rect.position.y
	
	return x + y * rect.size.x
	pass


func the_path(start,end):
	
	var start_tile = world_to_map(start)
	
	var end_tile = world_to_map(end)
	
	var start_id = make_id(start_tile)
	
	var end_id = make_id(end_tile)
	
	if not astar.has_point(start_id) or not astar.has_point(end_id):
		return null
		
	var path_map = astar.get_point_path(start_id,end_id)
	
	var path_world = []
	for point in path_map:
		var point_world = map_to_world(Vector2(point.x,point.y)) + half_cell
		path_world.append(point_world)
	return path_world
	pass


func _ready():
	
	#add_points(cell)
	#connect_points(cell)
	
	luz.set_visible(true)
	cena.mapa_index = mapa_index
	used_cells = ref_points.get_used_cells()
	#print(used_cells)
	cena.mapa_used_cells = used_cells
	pass
