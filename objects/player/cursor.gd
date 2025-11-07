extends Sprite2D 
class_name Cursor

@export var grid: Grid
@export var c : Character
@export var line : Line2D


var path : PackedVector2Array
var start : Vector2i = Vector2i(-999,-999)
var end : Vector2i= Vector2i(-999,-999)

var pos : Vector2i

func _ready():
	scale = Vector2(grid.size,grid.size) / texture.get_size()

func draw_path() -> void:
	line.clear_points()
	for i in path:
		line.add_point(grid.get_pos(i))

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var m_pos = get_global_mouse_position()
		pos = grid.normalize(m_pos)
		
		global_position = grid.get_pos(pos)
		hide()

		if pos.x >= -grid.map_size.x && pos.x <= grid.map_size.x && pos.y >= -grid.map_size.y && pos.y <= grid.map_size.y:
			show()
			if c != null:
				path = grid.find_path(c.pos,pos)	
				draw_path()
		
	if event.is_action_pressed("click"):
		var npos : Vector2i = grid.normalize(get_global_mouse_position())
		if grid.in_size(npos):
			
			if c == null:
				for i in grid.characters:
					if i.pos == pos && i is Player:
						c = i
			else:
				c.goto(grid.find_path(c.pos,npos))
				c = null
				line.clear_points()

	if event.is_action_pressed("right_click"):
		var npos : Vector2i = grid.normalize(get_global_mouse_position())
		if grid.in_size(npos):
			grid.switch(npos)
