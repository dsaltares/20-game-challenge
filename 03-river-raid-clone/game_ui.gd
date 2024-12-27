extends Control

@onready var score: Label = %Score
@onready var health_bar: ProgressBar = %HealthBar
@onready var fuel_bar: ProgressBar = %FuelBar

var player : Player

func _process(_delta: float) -> void:
	health_bar.min_value = 0.0
	health_bar.max_value = player.max_health
	health_bar.value = player.health

	fuel_bar.min_value = 0.0
	fuel_bar.max_value = player.max_fuel
	fuel_bar.value = player.fuel
