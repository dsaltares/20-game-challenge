@tool
class_name Laser
extends Node2D


@export var length := 70 : set = _set_length
@export var orientation := Orientation.VERTICAL : set = _set_orientation

@onready var laser_beam: LaserBeam = %LaserBeam
@onready var start: Sprite2D = %Start
@onready var end: Sprite2D = %End
@onready var pivot: Node2D = %Pivot

func _ready() -> void:
	_relayout()

func _set_length(new_length: int) -> void:
	length = new_length
	_relayout()

func _set_orientation(new_orientation: Orientation) -> void:
	orientation = new_orientation
	_relayout()
	
func _relayout() -> void:
	if not laser_beam or not start or not end:
		return
		
	laser_beam.length = length
	var emitter_height := start.texture.get_height() * start.scale.y
	start.position.y = -length * 0.5 - emitter_height * 0.5 + 5
	end.position.y = length * 0.5 + emitter_height * 0.5 - 5
	pivot.rotation_degrees = 0.0 if orientation == Orientation.VERTICAL else 90.0