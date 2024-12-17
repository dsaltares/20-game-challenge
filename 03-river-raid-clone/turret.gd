class_name Turret
extends Area2D

var target : Player

@onready var cannon: Sprite2D = $Cannon
@onready var shoot_timer: Timer = $ShootTimer
@onready var bullet_emitter: BulletEmitter = $Cannon/BulletEmitter

func _ready() -> void:
	bullet_emitter.ignore_body = self

func _physics_process(delta: float) -> void:
	if target == null:
		return
		
	cannon.look_at(target.global_position)

func hit(damage: float) -> void:
	die()

func die() -> void:
	queue_free()

func _on_detection_area_body_entered(body: Node2D) -> void:
	target = body as Player
	shoot_timer.start()

func _on_detection_area_body_exited(body: Node2D) -> void:
	target = null
	shoot_timer.stop()

func _on_shoot_timer_timeout() -> void:
	if target == null or target.state == Player.State.DEAD:
		return
		
	bullet_emitter.shoot()
