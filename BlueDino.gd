extends KinematicBody2D

var velocidad = Vector2(0,0)
const Speed = 80
const grav = 20
const Fsalto = -350


func _physics_process(delta):
	
	
	if Input.is_action_pressed("Reset"):
		get_tree().reload_current_scene()
		
	if Input.is_action_pressed("agachar"):
		$BlueDino.play("Sneak")
		$Standing.disabled = true
		if Input.is_action_pressed("Derecha") and is_on_floor():
			velocidad.x = Speed - 40
			$BlueDino.flip_h = false
		elif Input.is_action_pressed("Izquierda") and is_on_floor():
			velocidad.x = -Speed + 40
			$BlueDino.flip_h = true
		else:
			$BlueDino.play("Crouch")
	
	
	elif Input.is_action_pressed("Derecha"):
		$Standing.disabled = false
		velocidad.x = Speed
		$BlueDino.play("Move")
		$BlueDino.flip_h = false
		if Input.is_action_pressed("Correr"):
				velocidad.x = Speed + 50
				
	elif Input.is_action_pressed("Izquierda"):
		$Standing.disabled = false
		velocidad.x = -Speed
		$BlueDino.play("Move")
		$BlueDino.flip_h = true
		if Input.is_action_pressed("Correr"):
				velocidad.x = -Speed - 50
	else:
		$Standing.disabled = false
		$BlueDino.play("Idle")
	
	
	
	velocidad.y += grav
	
	if Input.is_action_pressed("Salto") and is_on_floor():
		velocidad.y = Fsalto
		$Salto.play()
	
	velocidad.y = move_and_slide(velocidad, Vector2.UP, true).y
	var slides = get_slide_count()
	if(slides):
			slope(slides)
		
func slope(slides: int):
	for i in slides:
		var touched = get_slide_collision(i)
		if is_on_floor() && touched.normal.y < 1.0 && velocidad.x != 0.0:
			velocidad.y = touched.normal.y

			
	velocidad.x = lerp(velocidad.x, 0, 0.8)
	
	
func _on_Area2D_body_entered(body):
	get_tree().change_scene("res://Niveles/Lvl2.tscn")
	
	
func bounce():
	velocidad.y = Fsalto * 0.7
	
func ouch(var enemposx):
	
	velocidad.y = Fsalto * 0.7
	
	
	if position.x < enemposx:
		velocidad.x = -150
	elif position.x > enemposx:
		velocidad.x = 150
		
	Input.action_release("Izquierda")
	Input.action_release("Derecha")




