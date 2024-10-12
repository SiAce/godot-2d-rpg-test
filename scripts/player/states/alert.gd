extends PlayerState

@export
var idle_state: State

var finished: bool

func enter(data={}) -> void:
	super.enter(data)
	finished = false
	
	var old_hp = parent.stats.HP.current
	var new_hp = parent.stats.HP.current - data.damage
	parent.stats.HP.current = new_hp
	parent.health_changed.emit(old_hp, new_hp, parent.stats.HP.max)
	
	
	var hit_direction = data.hit_direction
	parent.velocity.x = hit_direction * move_speed
	parent.velocity.y = -move_speed
	
	

func process_frame(delta: float) -> State:
	if finished:
		return idle_state
	if not parent.is_on_floor():
		parent.velocity.y += gravity * delta	
	parent.velocity.x = move_toward(parent.velocity.x, 0, move_speed / 40)
	parent.move_and_slide()
	return null

func _on_animations_animation_finished(anim_name: StringName) -> void:
	if anim_name == animation_name:
		finished = true
