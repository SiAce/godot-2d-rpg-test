class_name MP
extends VBoxContainer

@onready
var mp_number: Label = $mp_number
@onready
var mp_bar: ProgressBar = $mp_bar

func init(MP, max_MP):
  mp_number.text = "%s / %s" % [MP, max_MP]
  mp_bar.value = 100 * MP / max_MP

func on_player_mp_changed(old_mp: int, new_mp: int, max_mp: int) -> void:
  mp_number.text = "%s / %s" % [new_mp, max_mp]
  mp_bar.value = 100 * new_mp / max_mp
