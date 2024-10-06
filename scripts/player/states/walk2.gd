extends State

@export
var idle_state: State

func process_physics(delta: float) -> State:
	if not parent.is_on_floor():
		parent.velocity.y += gravity * delta	
	
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		parent.velocity.x = move_toward(parent.velocity.x, direction * move_speed, move_speed / 10)
	else:
		parent.velocity.x = move_toward(parent.velocity.x, 0, move_speed / 10)
	
	if direction == 0:
		return idle_state
	
	if direction > 0:
		parent.root_sprite.scale.x = -1
	elif direction < 0:
		parent.root_sprite.scale.x = 1
		
	parent.move_and_slide()
	
	return null
