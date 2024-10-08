extends PlayerState

@export
var move_state: State
@export
var attack_state: State

func process_physics(delta: float) -> State:
	if not parent.is_on_floor():
		parent.velocity.y += gravity * delta	
		
	if Input.is_action_pressed("attack"):
		return attack_state
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		return move_state
	parent.velocity.x = move_toward(parent.velocity.x, 0, move_speed / 10)
	parent.move_and_slide()
	
	return null
