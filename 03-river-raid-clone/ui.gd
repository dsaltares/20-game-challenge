class_name UI
extends Control

signal restart_game

@export var player : Player

@onready var game_ui: Control = $GameUI
@onready var game_over_ui: GameOverUI = $GameOverUI

func _ready() -> void:
	game_ui.player = player	

func _process(_delta: float) -> void:
	var game_enabled = player.state == Player.State.FLYING
	var game_over_enabled = player.state == Player.State.DEAD
	game_ui.set_process(game_enabled)
	game_ui.visible = game_enabled
	game_over_ui.set_process(game_over_enabled)
	game_over_ui.visible = game_over_enabled

func _on_game_over_ui_restart_game() -> void:
	restart_game.emit()
