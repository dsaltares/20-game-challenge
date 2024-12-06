class_name Main
extends Node2D

enum State {
	GAME,
	GAME_OVER
}

@export var units_per_meter := 100

@onready var player: Player = %Player
@onready var ui: UserInterface = %UI

var score := 0
var state := State.GAME

func _physics_process(delta: float) -> void:
	if state == State.GAME:
		_update_game(delta)
	
	_update_ui()

func _update_game(_delta: float) -> void:
	score = int(player.get_moved_distance() / 100)
	
func _update_ui() -> void:
	ui.score = score

func _on_player_died() -> void:
	state = State.GAME_OVER
	ui.state = UserInterface.State.GAME_OVER


func _on_ui_restart() -> void:
	get_tree().reload_current_scene()
	
