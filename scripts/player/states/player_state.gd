class_name PlayerState
extends State

@onready
var animation_name: String = self.name
@export
var move_speed: float = 120

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

## Hold a reference to the parent so that it can be controlled by the state
var parent: Player

func enter() -> void:
	for any_sprite_part_node in parent.root_sprite.get_children():
		any_sprite_part_node.visible = false
	for sprite_part in parent.animation_sprite_parts[animation_name]:
		var sprite_part_node = parent.get_node("flip/root_sprite/%s" % sprite_part)
		sprite_part_node.texture = parent.sprite_textures[animation_name][sprite_part]
		sprite_part_node.visible = true
		sprite_part_node.hframes = parent.animation_hframes[animation_name]
	
	parent.animations.play(animation_name)

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("1"):
		parent.reload_sprite_texture("weapon", "1")
		enter()
	if Input.is_action_just_pressed("2"):
		parent.reload_sprite_texture("weapon", "0")
		enter()
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	return null
