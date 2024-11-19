@tool

class_name GameCamera
extends Camera2D

@export var target : Player

func _physics_process(_delta: float) -> void:
	global_position.x = target.global_position.x
