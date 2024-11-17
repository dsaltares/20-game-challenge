class_name BoundsPair
extends Node2D

@onready var ground: Ground = $Ground

func get_width() -> int:
	return ground.get_width()
