class_name UserInterface
extends Control

signal restart

enum State {
	GAME,
	GAME_OVER
}

var score := 0
var state := State.GAME: get = get_state, set = set_state

@onready var game: Control = %Game
@onready var game_over: Control = %GameOver
@onready var score_label: Label = $Game/Score

func _ready() -> void:
	_update_visibility()

func _process(_delta: float) -> void:
	if state == State.GAME:
		_update_game()
	elif state == State.GAME_OVER:
		_update_game_over()

func _update_game() -> void:
	score_label.text = 'Score: %d' % score

func _update_game_over() -> void:
	if Input.is_action_just_pressed('boost'):
		restart.emit()

func get_state() -> State:
	return state
	
func set_state(new_state: State) -> void:
	state = new_state
	_update_visibility()

func _update_visibility() -> void:
	game.visible = state == State.GAME
	game_over.visible = state == State.GAME_OVER
