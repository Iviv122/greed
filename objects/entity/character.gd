extends Sprite2D
class_name Character

@export var grid: Grid
@export var start_pos :  Vector2i
var pos : Vector2i

func _ready():
	scale = Vector2(grid.size,grid.size) / texture.get_size()
	pos = start_pos 
	global_position = grid.get_pos(pos)

func move(dest : Vector2i):
	pos += dest
	pos = grid.clamp_pos(pos)
	global_position = grid.get_pos(pos)
