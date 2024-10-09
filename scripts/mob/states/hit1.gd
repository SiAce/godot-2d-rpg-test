extends MobState

@export
var move_state: State
@onready
var finished = false

func enter(data={}) -> void:
	finished = false
	
	parent.direction = 1 if data.area.global_position.x > parent.global_position.x else -1
	parent.flip.scale.x = -parent.direction
	
	parent.velocity.x = - parent.direction * move_speed
	parent.ani_sprite.play(animation_name)

func process_physics(delta: float) -> State:
	if finished:
		return move_state
		
	if not parent.is_on_floor():
		parent.velocity.y += gravity * delta
	parent.velocity.x = move_toward(parent.velocity.x, 0, move_speed / 30)
	parent.move_and_slide()
	return null

func _on_ani_sprite_animation_finished() -> void:
	if parent.ani_sprite.animation == animation_name:
		finished = true
