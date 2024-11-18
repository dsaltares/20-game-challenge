class_name Obstacle
extends AnimatableBody2D

@onready var sprite: Sprite2D = $Sprite

func get_width() -> int:
	return sprite.texture.get_width()
