class_name HealthPickUp
extends PickUp

@export var amount := 50.0

func give_to_player(player: Player) -> void:
	player.pick_up_health(amount)
