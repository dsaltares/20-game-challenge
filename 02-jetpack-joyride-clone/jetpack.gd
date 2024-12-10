class_name Jetpack
extends Node2D

@onready var flame_left: Sprite2D = $FlameLeft
@onready var flame_right: Sprite2D = $FlameRight

var ignited := false : set = set_ignited

func _ready() -> void:
	_update_visibility()

func set_ignited(new_ignited: bool) -> void:
	ignited = new_ignited
	_update_visibility()
	
func _update_visibility() -> void:
	flame_left.visible = ignited
	flame_right.visible = ignited
	
