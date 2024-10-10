class_name HitBox
extends Area2D

@export
var damage_modifier = 2

func calculate_damage() -> int:
	return damage_modifier * owner.equipments.weapon.attack
