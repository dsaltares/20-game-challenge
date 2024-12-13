class_name Main
extends Node2D

func _process(delta: float) -> void:
	if Input.is_action_just_pressed('restart'):
		get_tree().call_group('transient', 'queue_free')
		get_tree().reload_current_scene()
