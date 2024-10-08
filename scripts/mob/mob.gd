class_name Mob
extends CharacterBody2D

@onready
var state_machine = $state_machine
@onready
var ani_sprite = $flip/ani_sprite
@onready
var forward_ray: RayCast2D = $flip/forward
@onready
var flip: Node2D = $flip

func _ready() -> void:
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
