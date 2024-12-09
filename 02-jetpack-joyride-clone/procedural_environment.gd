class_name ProceduralEnvironment
extends Node2D

const LaserScene := preload('res://laser.tscn')
const LaserGroupScene := preload('res://laser_group.tscn')

@export var camera : GameCamera
@export var min_laser_height := 70
@export var max_laser_height := 300
@export var min_laser_length := 100
@export var max_laser_length := 600

const obstacle_probabilities := [
	{
		'threshold': 0,
		'probabilities': Vector3(1.0, 0.0, 0.0),
	},
	{
		'threshold': 50,
		'probabilities': Vector3(0.25, 0.75, 0.0),
	},
	{
		'threshold': 500,
		'probabilities': Vector3(0.05, 0.5, 0.45),
	},
]

var laser: Laser
var laser_group: LaserGroup
var score := 0
var ground_position := 0.0 : set = set_ground_position

func _ready() -> void:
	laser_group = LaserGroupScene.instantiate()
	add_child(laser_group)

func _physics_process(_delta: float) -> void:
	if _is_laser_group_behind():
		_randomize_laser_group_ahead()

func set_ground_position(new_pos: float) -> void:
	ground_position = new_pos
	_randomize_laser_group_ahead()

func _randomize_laser_group_ahead() -> void:
	var camera_rect := camera.get_rect()
	laser_group.global_position.x = camera_rect.position.x + camera_rect.size.x
	laser_group.global_position.y = camera_rect.position.y
	laser_group.available_height = camera.global_position.y - camera_rect.size.y * 0.5 + ground_position
	
	var count := _randomize_laser_count()
	laser_group.randomize(count)

func _is_laser_group_behind() -> bool:
	return camera.global_position.x > laser_group.global_position.x and not _is_laser_group_in_viewport()

func _is_laser_group_in_viewport() -> bool:
	var camera_rect := camera.get_rect()
	var laser_rect := laser_group.get_rect()
	return camera_rect.intersects(laser_rect)

# I don't think this returns the right numbers as you go up in score
func _randomize_laser_count() -> int:
	var selected_idx := 0
	for idx in range(obstacle_probabilities.size()):
		var current = obstacle_probabilities[idx]
		if current['threshold'] <= score:
			selected_idx = idx
		
	var selected = obstacle_probabilities[selected_idx]
	var next = selected
	if selected_idx < obstacle_probabilities.size() - 1:
		next = obstacle_probabilities[selected_idx + 1]
	
	var interval_size : int = next['threshold'] - selected['threshold']
	var weight := 1.0
	if interval_size > 0:
		weight = (score - selected['threshold']) / float(interval_size)
	
	var probabilities := (selected['probabilities'] as Vector3).lerp((next['probabilities'] as Vector3), weight)
	var roll := randf()
	if roll < probabilities.x:
		return 1
	if roll < probabilities.x + probabilities.y:
		return 2
	return 3
	
