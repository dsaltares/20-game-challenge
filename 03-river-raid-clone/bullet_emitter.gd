class_name BulletEmitter
extends Node2D

@export var BulletScene : PackedScene

var ignore_body : Node2D :
	set(new_ignore_body):
		ignore_body = new_ignore_body
		for child in get_children():
			if child is BulletEmitter:
				var emitter := child as BulletEmitter
				emitter.ignore_body = ignore_body

func shoot() -> void:
	if BulletScene != null:
		var node := BulletScene.instantiate()
		assert(node is Bullet)
		var bullet := node as Bullet
		bullet.ignore_body = ignore_body
		bullet.global_position = global_position
		bullet.global_rotation = global_rotation
		get_tree().root.add_child(bullet)
		
	
	for child in get_children():
		if child is BulletEmitter:
			var emitter := child as BulletEmitter
			emitter.shoot()
