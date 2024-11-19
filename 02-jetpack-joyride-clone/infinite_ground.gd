class_name InfiniteGround
extends Node2D

@export var camera : Camera2D

func _process(_delta: float) -> void:
	var first_layer : TileMapLayer = get_child(0)
	for layer in get_children():
		if layer.global_position.x < first_layer.global_position.x:
			first_layer = layer
			
	var last_layer : TileMapLayer = get_child(0)
	for layer in get_children():
		if layer.global_position.x > last_layer.global_position.x:
			last_layer = layer
	
	if !_is_layer_visible(first_layer):
		var last_layer_width := last_layer.get_used_rect().size.x * last_layer.tile_set.tile_size.x
		first_layer.global_position.x = last_layer.global_position.x + last_layer_width


func _is_layer_visible(layer: TileMapLayer) -> bool:
	var tile_size := layer.tile_set.tile_size
	var layer_size := Vector2(
		layer.get_used_rect().size.x * tile_size.x,
		layer.get_used_rect().size.y * tile_size.y,
	)
	var layer_rect := Rect2(layer.global_position, layer_size)
	var viewport_size := camera.get_viewport().get_visible_rect().size
	var half_viewport_size := viewport_size * 0.5 * camera.zoom
	var camera_rect = Rect2(
		camera.global_position - half_viewport_size,
		viewport_size * camera.zoom
	)
	return camera_rect.intersects(layer_rect)
