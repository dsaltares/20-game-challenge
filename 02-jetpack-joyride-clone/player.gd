class_name Player
extends CharacterBody2D

signal died

enum State {
	RUNNING,
	DEAD,
}

@export var gravity := 700.0
@export var boost_acceleration := -900.0
@export var horizontal_speed := 350.0
@export var death_drag := 250.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var jetpack: Jetpack = $Jetpack
@onready var start_pos := global_position

var state := State.RUNNING

func _physics_process(delta: float) -> void:
	_update_movement(delta)
	_update_animation()

func _update_movement(delta: float) -> void:
	var acceleration := gravity
	if state == State.RUNNING and Input.is_action_pressed('boost'):
		acceleration = boost_acceleration
		jetpack.ignited = true
	else:
		jetpack.ignited = false
	
	velocity.y += acceleration * delta
	
	if state == State.RUNNING:
		velocity.x = horizontal_speed
	else:
		velocity.x = max(velocity.x - death_drag * delta, 0.0)
	
	move_and_slide()
	
func _update_animation() -> void:
	if state == State.DEAD:
		animated_sprite.play('hurt')
	elif is_on_floor():
		animated_sprite.play('run')
	else:
		animated_sprite.play('jump')

func get_moved_distance() -> float:
	return global_position.x - start_pos.x

func die() -> void:
	if state == State.DEAD:
		return
		
	state = State.DEAD
	died.emit()
