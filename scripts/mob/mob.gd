class_name Mob
extends CharacterBody2D

@export
var direction = -1
@export
var max_hp = 100
@export
var damage = 2

@onready
var state_machine = $state_machine
@onready
var ani_sprite: AnimatedSprite2D = $flip/ani_sprite
@onready
var forward_ray: RayCast2D = $flip/forward
@onready
var flip: Node2D = $flip
@onready
var health_bar: ProgressBar = $ui/health_bar
@onready
var ui: Control = $ui
@onready
var current_hp = max_hp

func _ready() -> void:
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func _on_hithurtbox_body_entered(body: Node2D) -> void:
	if body is Player:
		var hit_direction = 1 if body.global_position.x > global_position.x else -1
		body.on_hit({"hit_direction": hit_direction, "damage": damage})

func _on_hithurtbox_area_entered(area: Area2D) -> void:
	if area is HitBox:
		state_machine.change_state($state_machine/hit1, {
			"hit_direction": 1 if global_position.x > area.global_position.x else -1,
			"damage": area.calculate_damage()
			})
