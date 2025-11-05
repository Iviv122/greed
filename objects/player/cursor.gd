extends Node2D
class_name Cursor

@export var grid: Grid

func _input(event):
	if event is InputEventMouseMotion:
		var pos = get_global_mouse_position()
		var x = ceil((pos.x - grid.size / 2) / grid.size)
		var y = ceil((pos.y - grid.size / 2) / grid.size)
		global_position = Vector2(x * grid.size, y * grid.size)
