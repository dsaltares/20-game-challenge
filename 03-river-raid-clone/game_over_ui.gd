class_name GameOverUI
extends Control

signal restart_game

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed('shoot'):
		restart_game.emit()
