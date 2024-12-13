class_name GameCamera
extends Camera2D

@export var target : Player

func _physics_process(delta: float) -> void:
	if not target:
		return
		
	global_position += target.locked_velocity * delta
