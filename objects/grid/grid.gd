extends Node2D
class_name Grid 

@export var size : int = 32
@export var test_tile : PackedScene
@export var map_size : Vector2i = Vector2i(5,5) 
@export var characters : Array[Character]

var id : int = 0	

var _astar := AStar2D.new() 


func _ready():

	create_map()

func create_map() -> void:
	id = 0 
	for y in range(-map_size.x,map_size.x+1):
		for x in range(-map_size.y,map_size.y+1):
			var p :Sprite2D = test_tile.instantiate() 
			p.global_position = get_pos(Vector2(x,y))
			add_child(p)
			_astar.add_point(id,Vector2(x,y))
			
			id += 1

	for y in range(-map_size.x,map_size.x+1):
		for x in range(-map_size.y,map_size.y+1):
			var current = Vector2i(x, y)
			var current_id = get_id(current)
			
			for dir in [Vector2i.UP, Vector2i.DOWN, Vector2i.LEFT, Vector2i.RIGHT]:
				var neighbor = current + dir
				if abs(neighbor.x) <= map_size.x and abs(neighbor.y) <= map_size.y:
					var neighbor_id = get_id(neighbor)
					if !_astar.are_points_connected(current_id,neighbor_id):
						print(current_id," ",neighbor_id)
						_astar.connect_points(current_id, neighbor_id, true)

func is_point_walkable(pos : Vector2) -> bool:
	if _astar.is_in_boundsv(pos):
		return not _astar.is_point_solid(pos)
	return false

func in_size(pos : Vector2i) -> bool:
	return pos.x >= -map_size.x && pos.x <= map_size.x && pos.y >= -map_size.y && pos.y <= map_size.y

func switch(pos : Vector2i) -> void:
	_astar.set_point_disabled(get_id(pos),!is_enabled(pos))

	var s : Sprite2D = get_child(get_id(pos))
	if is_enabled(pos):
		s.self_modulate = Color.RED
	else:
		s.self_modulate = Color.GREEN

func is_enabled(pos : Vector2i) -> bool:
	return _astar.is_point_disabled(get_id(pos))

func get_id(pos: Vector2i) -> int:
	var width = map_size.x * 2 + 1
	var x_index = pos.x + map_size.x
	var y_index = pos.y + map_size.y
	return y_index * width + x_index

func normalize(init_pos : Vector2) -> Vector2i:
	var pos : Vector2i

	pos.x = ceil((init_pos.x - size / 2.) / size)
	pos.y = ceil((init_pos.y - size / 2.) / size)

	return pos 

func clamp_pos(init_pos : Vector2i) -> Vector2i:
	var pos : Vector2i
	pos.x = clampi(init_pos.x,-map_size.x,map_size.x)
	pos.y = clampi(init_pos.y,-map_size.y,map_size.y)
	return pos 


func normalize_clamp(init_pos : Vector2) -> Vector2i:
	var pos : Vector2i

	pos.x = ceil((init_pos.x - size / 2.) / size)
	pos.x = clampi(pos.x,-map_size.x,map_size.x)
	pos.y = ceil((init_pos.y - size / 2.) / size)
	pos.y = clampi(pos.y,-map_size.y,map_size.y)

	return pos 

func get_pos(init_pos : Vector2i) -> Vector2:

	var n_x = init_pos.x * size
	var n_y = init_pos.y * size

	return Vector2(n_x,n_y)

func find_path(start_pos : Vector2i, end_pos : Vector2i) -> PackedVector2Array:

	var start = get_id(start_pos)
	var end = get_id(end_pos)
	var _path = _astar.get_point_path(start,end)

	return _path 
