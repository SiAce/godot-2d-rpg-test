extends MobState


func enter(data={}) -> void:
	parent.velocity.x = parent.direction * move_speed
	parent.ani_sprite.play(animation_name)

func process_physics(delta: float) -> State:
	if not parent.is_on_floor():
		parent.velocity.y += gravity * delta	
		
	if parent.forward_ray.is_colliding():
		parent.direction = -parent.direction
		parent.flip.scale.x = -parent.direction
		parent.velocity.x = -parent.velocity.x
	
	parent.move_and_slide()
	return null
