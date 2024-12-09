@tool

class_name GameCamera
extends Camera2D

@export var target : Player

func _physics_process(_delta: float) -> void:
	if not target:
		return
		
	global_position.x = target.global_position.x

func get_rect() -> Rect2:
	var viewport_size := get_viewport().get_visible_rect().size
	var half_viewport_size := viewport_size * 0.5 * zoom
	return Rect2(global_position + offset - half_viewport_size, viewport_size * zoom)
