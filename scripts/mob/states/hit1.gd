extends MobState

@export
var move_state: MobState
@export
var die_state: MobState
@onready
var finished = false

func enter(data={}) -> void:
	finished = false
	parent.current_hp -= data.damage
	parent.health_bar.value = 100 * parent.current_hp  / parent.max_hp
	var hit_direction = data.hit_direction
	parent.direction = -hit_direction
	parent.flip.scale.x = -parent.direction
	
	parent.velocity.x = - parent.direction * move_speed
	parent.ani_sprite.play(animation_name)

func process_physics(delta: float) -> State:
	if parent.current_hp <= 0:
		return die_state
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
