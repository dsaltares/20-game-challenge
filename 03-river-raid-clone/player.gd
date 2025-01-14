class_name Player
extends CharacterBody2D

signal died

enum State {
	FLYING,
	DEAD
}

const BulletScena := preload('res://bullet.tscn')

@export var free_speed := 750.0
@export var locked_velocity := Vector2.UP * 100
@export var fuel_consumption_by_1000_units := 5
@export var max_fuel := 100.0
@export var max_health := 100.0

@onready var guns: BulletEmitter = $Guns
@onready var last_position := global_position
@onready var fuel := max_fuel
@onready var health := max_health

var free_velocity := Vector2.ZERO
var state := State.FLYING

func _ready() -> void:
	guns.ignore_body = self

func _physics_process(delta: float) -> void:
	if state == State.FLYING:
		_update_flying(delta)
	elif state == State.DEAD:
		_update_dead(delta)

func hit(damage: float) -> void:
	health = max(health - damage, 0.0)
	if health <= 0.0:
		state = State.DEAD
		died.emit()

func pick_up_fuel(amount: float) -> void:
	fuel = min(fuel + amount, max_fuel)

func pick_up_health(amount: float) -> void:
	health = min(health + amount, max_health)

func _update_flying(delta: float) -> void:
	if Input.is_action_just_pressed('shoot'):
		_shoot()
		
	_move(delta)
	_update_fuel()

func _update_dead(delta) -> void:
	velocity = Utils.expDecayVector2(velocity, Vector2.ZERO, 5, delta)
	move_and_slide()

func _shoot() -> void:
	guns.shoot() 

func _move(delta: float) -> void:
	var direction := Input.get_vector('left', 'right', 'up', 'down')
	free_velocity = Utils.expDecayVector2(free_velocity, direction * free_speed, 20, delta)
	velocity = locked_velocity + free_velocity
	move_and_slide()
	
func _update_fuel() -> void:
	var distance_moved := last_position.distance_to(global_position)
	var fuel_consumed := distance_moved * fuel_consumption_by_1000_units / 1000.0
	fuel = maxf(fuel - fuel_consumed, 0)
	last_position = global_position
	
	if fuel <= 0:
		state = State.DEAD
		died.emit()
