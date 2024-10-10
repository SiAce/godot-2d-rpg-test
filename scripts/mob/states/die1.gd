extends MobState

@onready
var finished = false

func enter(data={}) -> void:
	finished = false
	parent.ani_sprite.play(animation_name)

func process_physics(delta: float) -> State:
	if finished:
		parent.queue_free()

	return null

func _on_ani_sprite_animation_finished() -> void:
	if parent.ani_sprite.animation == animation_name:
		finished = true
