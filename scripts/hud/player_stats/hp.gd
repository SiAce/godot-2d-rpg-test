class_name HP
extends VBoxContainer

@onready
var hp_number: Label = $hp_number
@onready
var hp_bar: ProgressBar = $hp_bar

func init(HP, max_HP):
  hp_number.text = "%s / %s" % [HP, max_HP]
  hp_bar.value = 100 * HP / max_HP

func on_player_HP_changed(old_HP: int, new_HP: int, max_HP: int) -> void:
  hp_number.text = "%s / %s" % [new_HP, max_HP]
  hp_bar.value = 100 * new_HP / max_HP
