class_name HP
extends VBoxContainer

@onready
var hp_number: Label = $hp_number
@onready
var hp_bar: ProgressBar = $hp_bar

func init(HP):
	hp_number.text = "%s / %s" % [HP.current, HP.max]
	hp_bar.value = 100 * HP.current / HP.max

func on_player_health_changed(old_hp: int, new_hp: int, max_hp: int) -> void:
	hp_number.text = "%s / %s" % [new_hp, max_hp]
	hp_bar.value = 100 * new_hp / max_hp
