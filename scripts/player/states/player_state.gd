class_name PlayerState
extends State

@onready
var animation_name: String = self.name
@export
var move_speed: float = 120

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

## Hold a reference to the parent so that it can be controlled by the state
var parent: Player

func enter(data={}) -> void:
	parent.swap_sprite_for_current_animation(animation_name)
	parent.animations.play(animation_name)

func exit(data={}) -> void:
	pass

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("1"):
		parent.change_weapon("1")
	if Input.is_action_just_pressed("2"):
		parent.change_weapon("0")
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	return null
