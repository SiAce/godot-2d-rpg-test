extends CanvasLayer

@onready
var hp: HP = $root/player_panel/player_container/player_stats/hp_mp_container/hp
@onready
var player: Player = $"../player"

func _ready() -> void:
	init_player_stats(player.stats)
	player.health_changed.connect(_on_player_health_changed)

func init_player_stats(stats):
	hp.init(stats.HP)

func _on_player_health_changed(old_hp: int, new_hp: int, max_hp: int) -> void:
	hp.on_player_health_changed(old_hp, new_hp, max_hp) # Replace with function body.
