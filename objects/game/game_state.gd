extends Node
class_name GameState

signal next()

func next_turn() -> void:
    next.emit()