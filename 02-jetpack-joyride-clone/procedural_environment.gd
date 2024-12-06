class_name ProceduralEnvironment
extends Node2D

const LaserScene := preload('res://laser.tscn')

@export var camera : GameCamera

@export var min_laser_height := 70
@export var max_laser_height := 300
@export var min_laser_length := 100
@export var max_laser_length := 600

var laser: Laser

func _ready() -> void:
	laser = LaserScene.instantiate()
	add_child(laser)
	_randomize_laser_ahead()

func _physics_process(delta: float) -> void:
	if _is_laser_behind():
		_randomize_laser_ahead()

func _randomize_laser_ahead() -> void:
	if randf() > 0.5:
		laser.orientation = Orientation.HORIZONTAL
	else:
		laser.orientation = Orientation.VERTICAL
		
	if laser.orientation == Orientation.HORIZONTAL:
		laser.length = randf_range(min_laser_length, max_laser_length)
	else:
		laser.length = randf_range(min_laser_height, max_laser_height)
		
	var laser_rect := laser.get_rect()
	var camera_rect := camera.get_rect()
	
	laser.global_position.x = camera.global_position.x + camera_rect.size.x + laser_rect.size.x * 0.5
	laser.global_position.y = randf_range(
		camera.global_position.y - laser_rect.size.y,
		camera.global_position.y + laser_rect.size.y,
	)

func _is_laser_behind() -> bool:
	return camera.global_position.x > laser.global_position.x and not _is_laser_in_viewport()

func _is_laser_in_viewport() -> bool:
	var camera_rect := camera.get_rect()
	var laser_rect := laser.get_rect()
	return camera_rect.intersects(laser_rect) or laser_rect.intersects(camera_rect)
