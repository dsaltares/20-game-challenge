class_name UserInterface
extends Control

var score := 0

@onready var score_label: Label = $Game/Score

func _process(_delta: float) -> void:
	_update_game()

func _update_game() -> void:
	score_label.text = 'Score: %d' % score
