class_name Player
extends CharacterBody2D

const animation_sprite_parts = {
	"stand2": ["body", "arm", "head", "weaponOverArm", "handOverHair"],
	"walk2": ["body", "arm", "head", "weaponOverArm", "handOverHair"],
	"swingP1": ["weaponBelowBody", "body", "arm", "head", "weaponBelowArm", "armOverHairBelowWeapon", "armOverHair"]
}

const animation_hframes = {
	"stand2": 4,
	"walk2": 4,
	"swingP1": 3
}

const reload_sprite_parts = {
	"weapon": {
		"stand2": ["weaponOverArm"],
		"walk2": ["weaponOverArm"],
		"swingP1": ["weaponBelowBody","weaponBelowArm"]
	}
}

@onready
var animations = $animations
@onready
var state_machine = $state_machine
@onready
var root_sprite = $flip/root_sprite
@onready
var flip = $flip
@onready
var sprite_textures = {}	

func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	for animation_name in animation_sprite_parts:
		var texture_all_parts = {}
		for sprite_part in animation_sprite_parts[animation_name]:
			texture_all_parts[sprite_part] = load("res://sprites/player/{animation_name}/{sprite_part}/{id}.png".format(
				{"animation_name": animation_name, "sprite_part": sprite_part, "id": "0"}))
		sprite_textures[animation_name] = texture_all_parts
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func reload_sprite_texture(reload_part: StringName, id: StringName):
	for animation_name in reload_sprite_parts[reload_part]:
		for sprite_part in reload_sprite_parts[reload_part][animation_name]:
			sprite_textures[animation_name][sprite_part] = load("res://sprites/player/{animation_name}/{sprite_part}/{id}.png".format(
				{"animation_name": animation_name, "sprite_part": sprite_part, "id": id}))
