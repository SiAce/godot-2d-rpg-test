class_name EXP
extends VBoxContainer

@onready
var exp_number: Label = $exp_number
@onready
var exp_bar: ProgressBar = $exp_bar

func init(EXP, max_EXP):
  exp_number.text = "%s / %s" % [EXP, max_EXP]
  exp_bar.value = 100 * EXP / max_EXP

func on_player_health_changed(old_exp: int, new_exp: int, max_exp: int) -> void:
  exp_number.text = "%s / %s" % [new_exp, max_exp]
  exp_bar.value = 100 * new_exp / max_exp
