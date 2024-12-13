class_name Player
extends CharacterBody2D

@export var speed := 650.0
@export var base_forward_speed := 300

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector('left', 'right', 'up', 'down')
	velocity = Vector2.UP * base_forward_speed
	velocity += direction * speed
	move_and_slide()
