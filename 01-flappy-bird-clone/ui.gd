class_name UI
extends Control

enum State {
	GAME,
	GAME_OVER
}

@onready var game_over: Control = $GameOver
@onready var game: Control = $Game
@onready var score_label: Label = %ScoreLabel

var score := 0
var state := State.GAME : set = _set_state

func _ready() -> void:
	game.visible = true
	game_over.visible = false

func _process(_delta: float) -> void:
	score_label.text = 'Score: %d' % score

func _set_state(new_state: State) -> void:
	state = new_state
	_update_visibility()
	
func _update_visibility() -> void:
	game.visible = state == State.GAME
	game_over.visible = state == State.GAME_OVER
