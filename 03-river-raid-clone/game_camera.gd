class_name GameCamera
extends Camera2D

@export var target : Player

func _physics_process(delta: float) -> void:
	if not target:
		return
		
	global_position += Vector2.UP * target.base_forward_speed * delta
