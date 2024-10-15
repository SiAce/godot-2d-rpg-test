class_name Attribute
extends HBoxContainer

@onready
var attribute_value_label: RichTextLabel = $value
@onready
var attribute_allocated_label: Label = $allocated
@onready
var minus_button: Button = $minus
@onready
var plus_button: Button = $plus

signal allocated_points_changed(new_value)
var allocated_points = 0:
  get:
    return allocated_points
  set(new_value):
    if allocated_points == 0 and new_value >= 1:
      minus_button.disabled = false
    elif new_value <= 0:
      minus_button.disabled = true
    attribute_allocated_label.text = str(new_value)
    allocated_points = new_value
    allocated_points_changed.emit(new_value)

func init(base_attributes, bonus_attributes):
  update_attribute(base_attributes, bonus_attributes)
  minus_button.pressed.connect(_on_minus_button_pressed)
  plus_button.pressed.connect(_on_plus_button_pressed)

func update_attribute(base_attributes, bonus_attributes):
    attribute_value_label.text = "[center]%s+[color=green]%s[/color][/center]" % [base_attributes[name], bonus_attributes[name]]

func _on_minus_button_pressed():
  allocated_points -= 1

func _on_plus_button_pressed():
  allocated_points += 1

func on_remain_points_changed(new_value):
  if new_value <= 0:
    plus_button.disabled = true
  else:
    plus_button.disabled = false
