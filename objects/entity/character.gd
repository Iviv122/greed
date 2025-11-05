extends Sprite2D
class_name Character

@export var grid: Grid
@export var start_pos :  Vector2i
var pos : Vector2i

var tween : Tween

func _ready():
	scale = Vector2(grid.size,grid.size) / texture.get_size()
	pos = start_pos 
	global_position = grid.get_pos(pos)
	moving()

func move(dest : Vector2i):
	pos += dest
	pos = grid.clamp_pos(pos)
	
	if tween:
		tween.kill()
	tween = create_tween().set_parallel()

	var fin_pos = grid.get_pos(pos)
	tween.tween_property(self,"global_position:x",fin_pos.x,0.1).set_trans(Tween.TRANS_ELASTIC)

	tween.tween_property(self,"global_position:y",fin_pos.y+grid.size,0.05).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(self,"global_position:y",fin_pos.y,0.05).set_trans(Tween.TRANS_ELASTIC)


func moving() -> void:
	await  get_tree().create_timer(0.5).timeout
	move(Vector2i(-1,-1))
	moving()
