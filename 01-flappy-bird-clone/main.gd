class_name Main
extends Node2D

@onready var environment: FlappyEnvironment = $Environment
@onready var player: Player = $Player


func _on_player_crashed() -> void:
	environment.state = FlappyEnvironment.EnvironmentState.STOPPED
