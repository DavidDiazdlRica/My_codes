extends KinematicBody2D
var speed = 15
var velocidad = Vector2()
var direccion = -1
signal damage_player

func _ready():

	if direccion == 1:
		$Slime.flip_h = true
	$Floorcheck.position.x = $CollisionShape2D.shape.get_extents().x * direccion
	
func _physics_process(delta):
	
	if is_on_wall() or not $Floorcheck.is_colliding() and is_on_floor():
		direccion = direccion * -1
		$Slime.flip_h = not $Slime.flip_h
		$Floorcheck.position.x = $CollisionShape2D.shape.get_extents().x * direccion
	velocidad.y += 20
	velocidad.x = speed * direccion
	velocidad = move_and_slide(velocidad, Vector2.UP)
	
func _on_Topcheck_body_entered(body):
	$Slime.modulate = Color(1,0,0)
	$Slime.play("death")
	speed = 0
	set_collision_layer_bit(4, false)
	set_collision_mask_bit(0, false)
	$Topcheck.set_collision_layer_bit(4, false)
	$Topcheck.set_collision_mask_bit(0, false)
	$Topcheck.set_collision_mask_bit(2, false)
	$Topcheck.set_collision_mask_bit(4, false)
	$Sidecheck.set_collision_layer_bit(4, false)
	$Sidecheck.set_collision_mask_bit(0, false)
	body.bounce()
	$Bounce.play()
	$Timer.start()
	$damaged.start()
	
func _on_Sidecheck_body_entered(body):
	emit_signal ("damage_player")
	body.ouch(position.x)
	
func _on_Timer_timeout():
	queue_free()
	
	
	


func _on_damaged_timeout():
	$Slime.modulate = Color(1,1,1)
