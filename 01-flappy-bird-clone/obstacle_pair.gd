class_name ObstaclePair
extends Node2D

signal avoided

@export var vertical_variance := 50.0

@onready var pivot: Node2D = $Pivot
@onready var down: Obstacle = $Pivot/Down
@onready var avoided_sfx: AudioStreamPlayer = $AvoidedSFX

func randomize() -> void:
	var half_variance := vertical_variance / 2.0
	pivot.position.y = randf_range(-half_variance, half_variance)

func get_width() -> int:
	return down.get_width()


func _on_area_2d_body_entered(_body: Node2D) -> void:
	avoided.emit()
	avoided_sfx.play()
