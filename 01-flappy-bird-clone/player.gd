class_name Player
extends CharacterBody2D

signal crashed

@export var gravity := 500
@export var flap_force := -400.0
@export var terminal_speed := 500.0
@export var fly_angle_degrees := 15.0
@export var fall_angle_degrees := -15.0
@export var time_to_align := 0.15

var rotation_alignment_time := 0.0

func _physics_process(delta: float) -> void:
	rotation_alignment_time += delta
	
	var was_flying := velocity.y < 0
	velocity.y += gravity * delta 
	
	if Input.is_action_just_pressed('jump'):
		velocity.y = flap_force
		   
	var is_flying := velocity.y < 0
	if was_flying != is_flying:
		rotation_alignment_time = 0
		
	velocity.y = clampf(velocity.y, -terminal_speed, terminal_speed)

	var rotation_alignment_weight := clampf(rotation_alignment_time / time_to_align, 0.0, 1.0)
	var target_roation_degrees := fly_angle_degrees if velocity.y > 0.0 else fall_angle_degrees
	rotation = lerp_angle(rotation, deg_to_rad(target_roation_degrees), rotation_alignment_weight)
	if rotation_alignment_time > time_to_align:
		rotation_degrees = target_roation_degrees
		
	var collides := move_and_slide()	
	if collides:
		crashed.emit()
