class_name State
extends Node

@export
var animation_name: String
@export
var move_speed: float = 120

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

## Hold a reference to the parent so that it can be controlled by the state
var parent: Player

func enter() -> void:
	for sprite_part_node in parent.root_sprite.get_children():
		sprite_part_node.texture = parent.sprite_textures[animation_name][sprite_part_node.name]
	parent.animations.play(animation_name)


func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("1"):
		parent.reload_sprite_texture("weaponOverArm", "1")
		enter()
	if Input.is_action_just_pressed("2"):
		parent.reload_sprite_texture("weaponOverArm", "weaponOverArm")
		enter()
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	return null
