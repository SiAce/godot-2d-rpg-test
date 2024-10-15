class_name Attributes
extends PanelContainer

@onready
var attributes_container: Container = $attributes_stats/attributes
@onready
var level_label: Label =$attributes_stats/attributes/level/value
@onready
var available_points_label: Label =$attributes_stats/attributes/available_points/value
@onready
var submit_button: Button = $attributes_stats/attributes/submit
var available_points = 0
var remain_points = 0:
  get:
    return remain_points
  set(new_value):
    remain_points = new_value
    on_remain_points_changed(new_value)

signal allocated_points_submitted(allocated_points)

func init(base_attributes, bonus_attributes, level, available_points):
  for child in attributes_container.get_children():
    if child is Attribute:
      child.init(base_attributes, bonus_attributes)
      child.allocated_points_changed.connect(_on_allocated_points_changed)
  level_label.text = str(level)
  self.available_points = available_points
  remain_points = available_points

func reset_points(available_points):
  for child in attributes_container.get_children():
    if child is Attribute:
      child.allocated_points = 0
  self.available_points = available_points
  remain_points = available_points
  
func on_remain_points_changed(new_value):
  available_points_label.text = str(new_value)
  for child in attributes_container.get_children():
    if child is Attribute:
      child.on_remain_points_changed(new_value)
  if new_value <= 0 and available_points > 0:
    submit_button.disabled = false
  else:
    submit_button.disabled = true
    
func _on_allocated_points_changed(new_value):
  var total_allocated_points = 0
  for child in attributes_container.get_children():
    if child is Attribute:
      total_allocated_points += child.allocated_points
  remain_points = available_points - total_allocated_points

func _on_submit_pressed() -> void:
  var allocated_attributes = {}
  for child in attributes_container.get_children():
    if child is Attribute:
      allocated_attributes[child.name] = child.allocated_points
  allocated_points_submitted.emit(allocated_attributes)
  reset_points(0)
  
func _on_base_attributes_changed(base_attributes, bonus_attributes):
    for child in attributes_container.get_children():
      if child is Attribute:
        child.update_attribute(base_attributes, bonus_attributes)
