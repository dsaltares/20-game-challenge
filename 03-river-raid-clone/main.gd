class_name Main
extends Node2D

func _ready() -> void:
	_setup_window()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed('restart'):
		restart_game()

func _setup_window() -> void:
	var screen_size := DisplayServer.screen_get_size()
	var viewport_size := get_viewport().get_visible_rect().size
	var max_width_multiple := floorf(screen_size.x / viewport_size.x)
	var max_height_multiple := floorf(screen_size.y / viewport_size.y)
	var scale_multiplier := mini(max_height_multiple, max_width_multiple)
	if max_width_multiple > max_height_multiple:
		scale_multiplier = max_height_multiple - 1
	var window_size := Vector2i(
		viewport_size.x * scale_multiplier,
		viewport_size.y * scale_multiplier
	)
	var centered_position := (screen_size - window_size) / 2
	DisplayServer.window_set_size(window_size)
	DisplayServer.window_set_position(centered_position)

func restart_game() -> void:
	get_tree().call_group('transient', 'queue_free')
	get_tree().reload_current_scene()
