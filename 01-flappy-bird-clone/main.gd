class_name Main
extends Node2D

@onready var environment: FlappyEnvironment = $Environment
@onready var player: Player = $Player
@onready var ui: UI = $UI

func _on_player_crashed() -> void:
	environment.state = FlappyEnvironment.EnvironmentState.STOPPED

func _on_obstacle_avoided() -> void:
	ui.score += 1
