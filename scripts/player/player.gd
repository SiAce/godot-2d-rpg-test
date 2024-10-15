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

const init_attributes = {
  "strength": 10,
  "dexterity": 10,
  "intelligence": 10,
  "luck": 10,
}

const init_stats = {
  "physical_attack": 1,
  "magical_attack": 1,
  "attack_speed": 100,
  "critical_rate": 0,
  "critical_damage": 175,
  "max_HP": 100,
  "max_MP": 100,
}

@onready
var animations = $animations
@onready
var state_machine: StateMachine = $state_machine
@onready
var root_sprite = $flip/root_sprite
@onready
var flip = $flip

signal base_attributes_changed(new_value)
var _base_attributes = init_attributes
var base_attributes:
  get:
    return _base_attributes
  set(value):
    _base_attributes = value
    base_attributes_changed.emit(value, bonus_attributes)
    
signal bonus_attributes_changed(new_value)
var _bonus_attributes = {
  "strength": 0,
  "dexterity": 0,
  "intelligence": 0,
  "luck": 0,
}
var bonus_attributes:
  get:
    return _bonus_attributes
  set(value):
    _bonus_attributes = value
    bonus_attributes_changed.emit(value)

signal base_stats_changed(new_value)
var _base_stats = init_stats
var base_stats:
  get:
    return _base_stats
  set(value):
    _base_stats = value
    base_stats_changed.emit(value)

signal bonus_stats_changed(new_value)
var _bonus_stats = {
  "physical_attack": 0,
  "magical_attack": 0,
  "attack_speed": 0,
  "critical_rate": 0,
  "critical_damage": 0,
  "max_HP": 0,
  "max_MP": 0,
}
var bonus_stats:
  get:
    return _bonus_stats
  set(value):
    _bonus_stats = value
    bonus_stats_changed.emit(value)
var total_stats:
  get:
    var _total_stats = {}
    for key in base_stats:
      _total_stats[key] = base_stats[key] + bonus_stats[key]
    return _total_stats

var sprite_textures = {}	
var equipments = {}
signal HP_changed(old_HP: int, new_HP: int, max_HP: int)
var HP = 100:
  get:
    return HP
  set(new_value):
    HP_changed.emit(HP, new_value, total_stats.max_HP)
    HP = new_value
    
signal MP_changed(old_MP: int, new_MP: int, max_MP: int)
var MP = 100:
  get:
    return MP
  set(new_value):
    MP_changed.emit(MP, new_value, total_stats.max_MP)
    MP = new_value
    
signal EXP_changed(old_EXP: int, new_EXP: int, max_EXP: int)
var EXP = 0:
  get:
    return EXP
  set(new_value):
    EXP_changed.emit(EXP, new_value, 100)
    EXP = new_value

signal level_changed(old_level, new_level)
var level = 1:
  get:
    return level
  set(new_value):
    level_changed.emit(level, new_value)
    level = new_value

var available_points = 5:
  get:
    return available_points
  set(new_value):
    available_points = new_value

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

func _on_allocated_points_submitted(allocated_points):
  var new_base_attributes = {}
  for attribute_name in base_attributes:
    new_base_attributes[attribute_name] = base_attributes[attribute_name] + allocated_points[attribute_name]
  base_attributes = new_base_attributes
