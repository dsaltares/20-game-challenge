@tool
class_name LaserBeam
extends StaticBody2D

@export var length := 70 : set = _set_length

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var sprite: Sprite2D = $Graphics/Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	_set_length(length)
	animation_player.play('glow')

func _set_length(new_length: int) -> void:
	length = new_length
	var scale_y := float(length) / float(sprite.texture.get_height())
	print('new_scale ', scale_y)
	sprite.scale.y = scale_y
	collision_shape.scale.y = scale_y
