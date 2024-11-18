class_name UI
extends Control

@onready var score_label: Label = %ScoreLabel

var score := 0

func _process(_delta: float) -> void:
	score_label.text = 'Score: %d' % score
