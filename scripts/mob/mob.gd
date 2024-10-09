class_name Mob
extends CharacterBody2D

@onready
var state_machine = $state_machine
@onready
var ani_sprite: AnimatedSprite2D = $flip/ani_sprite
@onready
var forward_ray: RayCast2D = $flip/forward
@onready
var flip: Node2D = $flip
@export
var direction = -1

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
		body.on_hit()

func _on_hithurtbox_area_entered(area: Area2D) -> void:
	state_machine.change_state($state_machine/hit1, {"area": area})
