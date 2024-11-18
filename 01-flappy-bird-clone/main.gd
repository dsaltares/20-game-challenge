class_name Main
extends Node2D

@onready var environment: FlappyEnvironment = $Environment
@onready var player: Player = $Player
@onready var ui: UI = %UI

var has_crashed := false

func _process(_delta: float) -> void:
	if has_crashed and Input.is_action_just_pressed('jump'):
		get_tree().reload_current_scene()

func _on_player_crashed() -> void:
	environment.state = FlappyEnvironment.State.STOPPED
	ui.state = UI.State.GAME_OVER
	has_crashed = true

func _on_obstacle_avoided() -> void:
	ui.score += 1
