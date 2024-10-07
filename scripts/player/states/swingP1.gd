extends PlayerState

@export
var idle_state: State

var finished: bool

func enter() -> void:
	super.enter()
	finished = false

func process_frame(delta: float) -> State:
	if finished:
		return idle_state
	return null

func _on_animations_animation_finished(anim_name: StringName) -> void:
	if anim_name == animation_name:
		finished = true
