class_name State
extends Node

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
