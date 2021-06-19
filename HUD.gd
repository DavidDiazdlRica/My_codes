extends CanvasLayer

var health = 3
var pollo = 0
var soundplayed = false
var soundplayedsecond = false

func _ready():
	$Nobjetos.text = String(pollo)
	$Nvidas.text = String(health)

func _physics_process(delta):
	if pollo >= 16 and !soundplayed:
		soundplayed = true
		$Primera.play()
	if pollo == 24 and !soundplayedsecond:
		soundplayedsecond = true
		$Segunda.play()
	if health <= 0:
		get_tree().reload_current_scene()

func _on_Pollo_pollo_recogido():
	pollo = pollo + 1
	_ready()

func _on_BigPollo_Bigpollo_recogido():
	pollo = pollo + 2
	_ready()

func _on_Slime_damage_player():
	health = health - 1
	$AudioStreamPlayer2D.play()
	_ready()

func _on_Worm_damage_player():
	health = health - 1
	$AudioStreamPlayer2D.play()
	_ready()

func _on_Trap_damage_by_trap():
	health = health - 2
	$AudioStreamPlayer2D.play()
	_ready()

func _on_Trap2_damage_by_trap():
	health = health - 1
	$AudioStreamPlayer2D.play()
	_ready()
	
func _on_Vida_Vida_recogida():
	if health <=2:
		health = health + 1
		_ready()
	else:
		health = 3
