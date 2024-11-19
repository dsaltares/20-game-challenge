class_name Player
extends CharacterBody2D

@export var gravity := 700.0
@export var boost_acceleration := -900.0
@export var horizontal_speed := 350.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	_update_movement(delta)
	_update_animation()

func _update_movement(delta: float) -> void:
	var acceleration := gravity
	if Input.is_action_pressed('boost'):
		acceleration = boost_acceleration
	
	velocity.y += acceleration * delta
	velocity.x = horizontal_speed
	
	move_and_slide()
	
func _update_animation() -> void:
	if is_on_floor():
		animated_sprite.play('run')
	else:
		animated_sprite.play('jump')
