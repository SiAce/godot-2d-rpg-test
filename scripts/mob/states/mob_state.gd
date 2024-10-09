class_name MobState
extends State

@onready
var animation_name: String = self.name
@export
var move_speed: float = 60
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")


## Hold a reference to the parent so that it can be controlled by the state
var parent: Mob

func enter(data={}) -> void:
	pass

func exit(data={}) -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	return null
