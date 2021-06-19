extends StaticBody2D
signal damage_by_trap


func _on_Topcheck_body_entered(body):
	if body.get_name() == "BlueDino":
		emit_signal ("damage_by_trap")
		body.ouch(position.x)
