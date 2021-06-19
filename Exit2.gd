extends StaticBody2D

var pollo = 0

func _on_Pollo_pollo_recogido():
	pollo = pollo + 1
	
func _on_BigPollo_Bigpollo_recogido():
	pollo = pollo + 2
	
	#Desactiva el bloqueo si el jugador tiene 15 o mas objetos
func _physics_process(delta):
	if pollo >= 16:
		queue_free()
