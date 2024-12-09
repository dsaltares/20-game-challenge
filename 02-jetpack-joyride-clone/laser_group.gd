class_name LaserGroup
extends Node2D

const LaserScene := preload('res://laser.tscn')

@export var min_laser_height := 70
@export var max_laser_height := 300
@export var min_laser_length := 100
@export var max_laser_length := 600

var camera : GameCamera
var available_height := 100

func get_rect() -> Rect2:
	var rect := Rect2()
	for laser in get_children() as Array[Laser]:
		rect = rect.merge(laser.get_rect())
	return rect;

func randomize(count: int) -> void:
	for child in get_children():
		child.queue_free()
	
	for i in range(count):
		var laser := LaserScene.instantiate()
		add_child(laser)

	var orientation := Orientation.VERTICAL
	if randf() > 0.5:
		orientation = Orientation.HORIZONTAL
	
	for laser in get_children() as Array[Laser]:
		laser.orientation = orientation
		laser.length = _get_random_laser_length(orientation)
		
	if orientation == Orientation.VERTICAL:
		_distribute_vertical_lasers()
	else:
		_distribute_horizontal_lasers()

func _get_random_laser_length(orientation: Orientation) -> float:
	if orientation == Orientation.VERTICAL:
		return randf_range(min_laser_height, max_laser_height)
	return randf_range(min_laser_length, max_laser_length)
	
func _distribute_horizontal_lasers() -> void:
	var lasers := get_children()
	lasers.shuffle()
	
	var rect := (lasers[0] as Laser).get_rect()
	var vertical_separation := randf_range(150, 300)
	var horizontal_offset := randf_range(0, 200)
	var total_height_needed := vertical_separation * (lasers.size() - 1) + rect.size.y * lasers.size()
	var y_start := randf_range(0, available_height - total_height_needed)
	
	for laser_idx in range(lasers.size()):
		var laser := lasers[laser_idx] as Laser
		laser.position.x = horizontal_offset * laser_idx + laser.get_rect().size.x * 0.5
		laser.position.y = y_start + vertical_separation * laser_idx + laser.get_rect().size.y * 0.5 * (laser_idx + 1)

func _distribute_vertical_lasers() -> void:
	var lasers := get_children()
	lasers.shuffle()
	
	var max_height := 0.0
	for laser in lasers:
		var height := (laser as Laser).get_rect().size.y
		if height > max_height:
			max_height = height
	
	var horizontal_separation := randf_range(150, 300)
	var vertical_offset := 0.0
	if lasers.size() > 1 and available_height - max_height > 0:
		vertical_offset = randf_range(0, available_height - max_height) / (lasers.size() - 1)
	var total_height_needed := max_height + vertical_offset * (lasers.size() - 1)
	var y_start := randf_range(0, available_height - total_height_needed)
	
	for laser_idx in range(lasers.size()):
		var laser := lasers[laser_idx] as Laser
		laser.position.x = horizontal_separation * laser_idx + laser.get_rect().size.x * 0.5
		laser.position.y = y_start + laser_idx * vertical_offset + laser.get_rect().size.y * 0.5
	
