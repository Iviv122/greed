extends Button
class_name NextTurn 

func _pressed() -> void:
    GameStateInstance.next_turn()