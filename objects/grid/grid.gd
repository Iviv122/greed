extends Node2D
class_name Grid 

@export var size : int = 32

@export var test_tile : PackedScene

func normalize(init_pos : Vector2) -> Vector2:
	var n_x = floor(init_pos.x) % size
	var n_y = floor(init_pos.y) % size
	return Vector2(n_x,n_y)

func get_pos(init_pos : Vector2) -> Vector2:

	var n_x = init_pos.x * size
	var n_y = init_pos.y * size

	return Vector2(n_x,n_y)

func _ready():
	for x in range(-5,6):
		for y in range(-5,6):
			var p :Sprite2D = test_tile.instantiate() 
			p.global_position = get_pos(Vector2(x,y))
			print(p.global_position)
			add_child(p)
