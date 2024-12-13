class_name Utils
extends Node

# https://www.youtube.com/watch?v=LSNQuFEDOyQ
# Decay: [1, 26]
static func expDecay(a: float, b: float, decay: float, delta: float) -> float:
	return b + (a - b) * exp(-decay * delta)
	
static func expDecayVector2(a: Vector2, b: Vector2, decay: float, delta: float) -> Vector2:
	return b + (a - b) * exp(-decay * delta)
	
static func expDecayVector3(a: Vector3, b: Vector3, decay: float, delta: float) -> Vector3:
	return b + (a - b) * exp(-decay * delta)
