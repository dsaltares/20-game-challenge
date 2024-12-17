class_name Player
extends CharacterBody2D

const BulletScena := preload('res://bullet.tscn')

@export var free_speed := 750.0
@export var locked_velocity := Vector2.UP * 300

@onready var guns: BulletEmitter = $Guns

var free_velocity = Vector2.ZERO

func _ready() -> void:
	guns.ignore_body = self

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector('left', 'right', 'up', 'down')
	free_velocity = Utils.expDecayVector2(free_velocity, direction * free_speed, 20, delta)
	velocity = locked_velocity + free_velocity
	move_and_slide()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed('shoot'):
		shoot()

func shoot() -> void:
	guns.shoot() 
