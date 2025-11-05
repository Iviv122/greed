extends Character
class_name Enemy

@export var player : Player 

func goto_single(points : PackedVector2Array) -> void:
	
	if  points.size() > 1:
		move(points[1])

func chase() -> void:
	goto_single(grid.find_path(pos,player.pos))

func on_spawn() -> void:
	GameStateInstance.next.connect(chase)
