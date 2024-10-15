extends CanvasLayer

@onready
var hp: HP = $root/player_panel/player_container/player_stats/hp_mp_container/hp
@onready
var mp: MP = $root/player_panel/player_container/player_stats/hp_mp_container/mp
@onready
var exp: EXP = $root/player_panel/player_container/player_stats/exp_container/exp
@onready
var player: Player = $"../player"
@onready
var attributes: Attributes = $root/attributes_panel

func _ready() -> void:
  init_player_stats(player.base_stats, player.bonus_stats, player.HP, player.MP, player.EXP)
  attributes.init(player.base_attributes, player.bonus_attributes, player.level, player.available_points)
  player.HP_changed.connect(_on_player_HP_changed)
  attributes.allocated_points_submitted.connect(player._on_allocated_points_submitted)
  player.base_attributes_changed.connect(attributes._on_base_attributes_changed)

func init_player_stats(base_stats, bonus_stats, HP, MP, EXP):
  hp.init(HP, base_stats.max_HP + bonus_stats.max_HP)
  mp.init(MP, base_stats.max_MP + bonus_stats.max_MP)
  exp.init(EXP, 100)

func _on_player_HP_changed(old_HP: int, new_HP: int, max_HP: int) -> void:
  print(old_HP, new_HP, max_HP)
  hp.on_player_HP_changed(old_HP, new_HP, max_HP) # Replace with function body.
