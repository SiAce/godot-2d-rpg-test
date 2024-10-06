class_name Player
extends CharacterBody2D

const sprite_parts = ["body", "arm", "head", "weaponOverArm", "handOverHair"]
const animation_names = ["stand2", "walk2"]

@onready
var animations = $animations
@onready
var state_machine = $state_machine
@onready
var root_sprite = $root_sprite
@onready
var sprite_textures = {}	

func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	for animation_name in animation_names:
		var texture_all_parts = {}
		for sprite_part in sprite_parts:
			texture_all_parts[sprite_part] = load("res://sprites/player/{animation_name}/{sprite_part}/{sprite_part}.png".format(
				{"animation_name": animation_name, "sprite_part": sprite_part}))
		sprite_textures[animation_name] = texture_all_parts
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func reload_sprite_texture(sprite_part: StringName, id: StringName):
	for animation_name in animation_names:
		sprite_textures[animation_name][sprite_part] = load("res://sprites/player/{animation_name}/{sprite_part}/{id}.png".format(
			{"animation_name": animation_name, "sprite_part": sprite_part, "id": id}))
