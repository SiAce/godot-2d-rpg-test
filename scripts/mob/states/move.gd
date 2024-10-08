extends MobState

@export
var idle_state: State
@export
var attack_state: State

func enter() -> void:
	parent.velocity.x = -move_speed

func process_physics(delta: float) -> State:
	if not parent.is_on_floor():
		parent.velocity.y += gravity * delta	
		
	if parent.forward_ray.is_colliding():
		parent.flip.scale.x = -parent.flip.scale.x
		parent.velocity.x = -parent.velocity.x
	
	parent.move_and_slide()
	return null
