extends Sprite2D 
class_name Cursor

@export var grid: Grid
@export var c : Character

var start : Vector2i = Vector2i(-999,-999)
var end : Vector2i= Vector2i(-999,-999)

var pos : Vector2

func _ready():
	scale = Vector2(grid.size,grid.size) / texture.get_size()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var m_pos = get_global_mouse_position()
		pos.x = ceil((m_pos.x - grid.size / 2.) / grid.size)
		pos.y = ceil((m_pos.y - grid.size / 2.) / grid.size)
		
		global_position = Vector2(pos.x * grid.size, pos.y * grid.size)
		hide()

		if pos.x >= -grid.map_size.x && pos.x <= grid.map_size.x && pos.y >= -grid.map_size.y && pos.y <= grid.map_size.y:
			show()
		
	if event.is_action_pressed("click"):
		var npos : Vector2i = grid.normalize(get_global_mouse_position())
		if grid.in_size(npos):
			c.goto(grid.find_path(c.pos,npos))
			print(npos, " ", grid.get_id(npos))
	if event.is_action_pressed("right_click"):
		var npos : Vector2i = grid.normalize(get_global_mouse_position())
		if grid.in_size(npos):
			grid.switch(npos)
			print("turned off")