class_name Bullet
extends Node2D

@export var speed := 1500.0
@export var damage := 10

@onready var sprite: Sprite2D = $Sprite2D
@onready var hitbox: Area2D = $Hitbox

var ignore_body : Node2D

func _physics_process(delta: float) -> void:
	var forward := global_transform.x.normalized()
	global_position += forward * speed * delta

func _on_hitbox_body_entered(body: Node2D) -> void:
	if ignore_body == body:
		return
		
	hit(body)
	
func _on_hitbox_area_entered(area: Area2D) -> void:
	if ignore_body == area:
		return
	
	hit(area)

func set_ignore(body: Node2D) -> void:
	hitbox.ignore

func hit(body: Node2D) -> void:
	if body.has_method('hit'):
		body.call('hit', damage)
	queue_free()
