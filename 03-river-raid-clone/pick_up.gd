class_name PickUp
extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if not (body is Player):
		return
	
	var player := body as Player
	give_to_player(player)
	queue_free()

func give_to_player(player: Player) -> void:
	pass
