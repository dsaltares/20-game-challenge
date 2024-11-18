class_name FlappyEnvironment
extends Node2D

signal obstacle_avoided

enum EnvironmentState {
	MOVING,
	STOPPED
}

@export var speed := 150.0
@export var background_speed := 0.05
@export var obstacle_variance := 200

@onready var background: Sprite2D = $Background
@onready var bounds: Node2D = %Bounds
@onready var obstacles: Node2D = %Obstacles
var state : EnvironmentState = EnvironmentState.MOVING
var background_offset := 0.0

func _ready() -> void:
	for pair: ObstaclePair in obstacles.get_children():
		pair.randomize()
		pair.connect('avoided', _on_obstacle_avoided)

func _physics_process(delta: float) -> void:
	if state == EnvironmentState.MOVING:
		_update_bounds(delta)
		_update_obstacles(delta)
	
	_update_background(delta)


func _update_bounds(delta: float) -> void:
	for pair: BoundsPair in bounds.get_children():
		pair.global_position.x -= speed * delta

	var max_x := -INF
	for pair: BoundsPair in bounds.get_children():
		if pair.global_position.x > max_x:
			max_x = pair.global_position.x

	for pair: BoundsPair in bounds.get_children():
		if pair.global_position.x < -pair.get_width():
			pair.global_position.x = max_x + pair.get_width()
			
func _update_obstacles(delta: float) -> void:
	for pair: ObstaclePair in obstacles.get_children():
		pair.global_position.x -= speed * delta
		
	var max_x := -INF
	for pair: ObstaclePair in obstacles.get_children():
		if pair.global_position.x > max_x:
			max_x = pair.global_position.x

	for pair: ObstaclePair in obstacles.get_children():
		if pair.global_position.x < -pair.get_width():
			pair.global_position.x = max_x + 800 + randf_range(-obstacle_variance, obstacle_variance)
			pair.randomize()

func _update_background(delta: float) -> void:
	var speed := background_speed if state == EnvironmentState.MOVING else 0.0
	background_offset += speed * delta
	background.material.set_shader_parameter('offset', background_offset)

func _on_obstacle_avoided() -> void:
	obstacle_avoided.emit()
