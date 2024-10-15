extends MobState

@export
var move_state: MobState
@export
var die_state: MobState
@onready
var finished = false
@onready
var damage_number_font: FontFile = preload("res://fonts/NoRed0.0-Sheet.png")


func enter(data={}) -> void:
  finished = false
  parent.current_hp -= data.damage
  parent.health_bar.value = 100 * parent.current_hp  / parent.max_hp
  var hit_direction = data.hit_direction
  parent.direction = -hit_direction
  parent.flip.scale.x = -parent.direction
  
  parent.velocity.x = - parent.direction * move_speed
  parent.ani_sprite.play(animation_name)
  
  show_damage_number(parent.ui, data.damage)

func process_physics(delta: float) -> State:
  if parent.current_hp <= 0:
    return die_state
  if finished:
    return move_state
    
  if not parent.is_on_floor():
    parent.velocity.y += gravity * delta
  parent.velocity.x = move_toward(parent.velocity.x, 0, move_speed / 30)
  parent.move_and_slide()
  return null

func _on_ani_sprite_animation_finished() -> void:
  if parent.ani_sprite.animation == animation_name:
    finished = true

func show_damage_number(ui: Control, value: int, crit=false):
  var tween: Tween = create_tween()
  var label: Label = Label.new()
  
  label.add_theme_font_size_override("font_size", 20)
  label.add_theme_font_override("font", damage_number_font)
  label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
  label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
  label.text = str(value)
  ui.add_child(label)
  label.position.x = - label.size.x / 2
  label.position.y = -40
  tween.tween_property(label, "position:y", label.position.y - 15, 1)
  tween.parallel().tween_property(label, "modulate:a", 0, 1)
  tween.tween_callback(label.queue_free)
  
