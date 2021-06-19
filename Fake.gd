extends TileMap

func _on_Area2D_body_entered(body):
	if body.get_name() == "BlueDino":
		visible = false


func _on_Area2D_body_exited(body):
	if body.get_name() == "BlueDino":
		visible = true
