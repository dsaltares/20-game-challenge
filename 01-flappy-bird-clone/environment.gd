class_name FlappyEnvironment
extends Node2D

@export var speed := 150.0

@onready var bounds: Node2D = %Bounds

func _physics_process(delta: float) -> void:
	for pair: BoundsPair in bounds.get_children():
		pair.global_position.x -= speed * delta

	var max_x := -INF
	for pair: BoundsPair in bounds.get_children():
		if pair.global_position.x > max_x:
			max_x = pair.global_position.x
	

	for pair: BoundsPair in bounds.get_children():
		if pair.global_position.x < -pair.get_width():
			pair.global_position.x = max_x + pair.get_width()
