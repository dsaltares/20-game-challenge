class_name GameCamera
extends Camera2D

@export var target : Player

@onready var bottom: CollisionShape2D = $Bounds/Bottom
@onready var top: CollisionShape2D = $Bounds/Top
@onready var left: CollisionShape2D = $Bounds/Left
@onready var right: CollisionShape2D = $Bounds/Right

func _ready() -> void:
	var viewport_rect := get_viewport_rect()
	bottom.position = Vector2(0.0, viewport_rect.size.y * 0.5 * zoom.y)
	top.position = Vector2(0.0, -viewport_rect.size.y * 0.5 * zoom.y)
	right.position = Vector2(viewport_rect.size.x * 0.5 * zoom.x, 0.0)
	left.position = Vector2(-viewport_rect.size.x * 0.5 * zoom.x, 0.0)

func _physics_process(delta: float) -> void:
	if not target:
		return
		
	global_position += target.locked_velocity * delta
