extends Sprite2D
class_name Character

@export var grid: Grid
@export var start_pos :  Vector2i
var pos : Vector2i

var tween : Tween

func _input(event):
	if event.is_action_pressed("w"):
		move(Vector2i.UP)
	if event.is_action_pressed("s"):
		move(Vector2i.DOWN)
	if event.is_action_pressed("a"):
		move(Vector2i.LEFT)
	if event.is_action_pressed("d"):
		move(Vector2i.RIGHT)
	

func _ready():
	scale = Vector2(grid.size,grid.size) / texture.get_size()
	pos = start_pos 
	global_position = grid.get_pos(pos)

func move(dest : Vector2i):
	pos += dest
	pos = grid.clamp_pos(pos)
	
	if tween:
		tween.kill()
	tween = create_tween().set_parallel()

	var fin_pos = grid.get_pos(pos)
	var delta = fin_pos - global_position

	var animation_time = 0.3

	tween.tween_property(self,"global_position:x",global_position.x+delta.x,animation_time)

	tween.tween_property(self,"global_position:y",global_position.y+delta.y-grid.size,animation_time/2)
	tween.tween_property(self,"global_position:y",global_position.y+delta.y,animation_time/2).set_delay(animation_time/2)

