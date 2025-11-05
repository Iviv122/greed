extends Sprite2D
class_name Character

@export var grid: Grid
@export var start_pos :  Vector2i
@export var animation_time = 0.2

var pos : Vector2i
var tween : Tween

func _ready():
	scale = Vector2(grid.size,grid.size) / texture.get_size()
	pos = start_pos 
	global_position = grid.get_pos(pos)

func goto(points : PackedVector2Array) -> void:
	for i in range(1,points.size()):
		move(points[i])
		await get_tree().create_timer(animation_time).timeout

func move(dest : Vector2i):
	pos = dest
	pos = grid.clamp_pos(pos)
	
	if tween:
		tween.kill()
	tween = create_tween().set_parallel()

	var fin_pos = grid.get_pos(pos)
	var delta = fin_pos - global_position

	print(pos," ",grid.get_id(pos))

	tween.tween_property(self,"global_position:x",global_position.x+delta.x,animation_time).set_trans(Tween.TRANS_SINE)

	tween.tween_property(self,"global_position:y",global_position.y+delta.y-grid.size,animation_time/2).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self,"global_position:y",global_position.y+delta.y,animation_time/2).set_delay(animation_time/2).set_trans(Tween.TRANS_SINE)
