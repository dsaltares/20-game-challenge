class_name UI
extends Control

@export var player : Player

@onready var game_ui: Control = $GameUI

func _ready() -> void:
	game_ui.player = player	
