extends Area2D

export (Deaths.Type) var death_type = Deaths.Type.Fire

func _on_body_entered(body):
	print("ENTERED")
	if body.name == "player":
		body.die(death_type)
