class_name Player
extends CharacterBody2D

const animation_sprite_parts = {
	"alert": ["body", "head", "armOverHair", "weaponOverArm", "handBelowWeapon", "handOverHair"],
	"stand2": ["body", "arm", "head", "weaponOverArm", "handOverHair"],
	"walk2": ["body", "arm", "head", "weaponOverArm", "handOverHair"],
	"swingP1": ["weaponBelowBody", "body", "arm", "head", "weaponBelowArm", "armOverHairBelowWeapon", "armOverHair"]
}

const animation_hframes = {
	"alert": 4,
	"stand2": 4,
	"walk2": 4,
	"swingP1": 3
}

const reload_sprite_parts = {
	"weapon": {
		"alert": ["weaponOverArm"],
		"stand2": ["weaponOverArm"],
		"walk2": ["weaponOverArm"],
		"swingP1": ["weaponBelowBody","weaponBelowArm"]
	}
}

const equipment_database = {
	"weapon": {
		"0": {
			"attack": 2
		},
		"1": {
			"attack": 1
		}
	}
}

@onready
var animations = $animations
@onready
var state_machine: StateMachine = $state_machine
@onready
var root_sprite = $flip/root_sprite
@onready
var flip = $flip
@onready
var sprite_textures = {}	
var equipments = {}

func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	for animation_name in animation_sprite_parts:
		var texture_all_parts = {}
		for sprite_part in animation_sprite_parts[animation_name]:
			texture_all_parts[sprite_part] = load("res://sprites/player/{animation_name}/{sprite_part}/{id}.png".format(
				{"animation_name": animation_name, "sprite_part": sprite_part, "id": "0"}))
		sprite_textures[animation_name] = texture_all_parts
	equipments.weapon = equipment_database.weapon["0"]
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func change_weapon(weapon_id: StringName) -> void:
	equipments.weapon = equipment_database.weapon[weapon_id]
	reload_sprite_texture("weapon", weapon_id)
	swap_sprite_for_current_animation(state_machine.current_state.animation_name)

func reload_sprite_texture(reload_part: StringName, id: StringName):
	for animation_name in reload_sprite_parts[reload_part]:
		for sprite_part in reload_sprite_parts[reload_part][animation_name]:
			sprite_textures[animation_name][sprite_part] = load("res://sprites/player/{animation_name}/{sprite_part}/{id}.png".format(
				{"animation_name": animation_name, "sprite_part": sprite_part, "id": id}))

func swap_sprite_for_current_animation(animation_name: StringName):
	for any_sprite_part_node in root_sprite.get_children():
		any_sprite_part_node.visible = false
	for sprite_part in animation_sprite_parts[animation_name]:
		var sprite_part_node = get_node("flip/root_sprite/%s" % sprite_part)
		sprite_part_node.texture = sprite_textures[animation_name][sprite_part]
		sprite_part_node.visible = true
		sprite_part_node.hframes = animation_hframes[animation_name]

func on_hit(data={}):
	if state_machine.current_state != $state_machine/alert:
		state_machine.change_state($state_machine/alert, data)
