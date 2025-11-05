extends Node2D
class_name Grid 

@export var size : int = 32
@export var test_tile : PackedScene
@export var map_size : Vector2i = Vector2i(5,5) 

var map  

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

func _ready():
	for x in range(-map_size.x,map_size.x+1):
		for y in range(-map_size.y,map_size.y+1):
			var p :Sprite2D = test_tile.instantiate() 
			p.global_position = get_pos(Vector2(x,y))
			print(p.global_position)
			add_child(p)
