extends Sprite2D 
class_name Cursor

@export var grid: Grid

var pos : Vector2

func _ready():
	scale = Vector2(grid.size,grid.size) / texture.get_size()

func _input(event):
	if event is InputEventMouseMotion:
		var pos = get_global_mouse_position()
		pos.x = ceil((pos.x - grid.size / 2.) / grid.size)
		pos.y = ceil((pos.y - grid.size / 2.) / grid.size)
		global_position = Vector2(pos.x * grid.size, pos.y * grid.size)
		print(pos)
