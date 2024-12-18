extends Node2D

signal flipped

@export var out_direction_1 : Vector2:
	set(value):
		out_direction_1 = value
		$TurnTrigger.out_direction_1 = value

@export var out_direction_2 : Vector2:
	set(value):
		out_direction_2 = value
		$TurnTrigger.out_direction_2 = value


func _on_clickable_area_pressed() -> void:
	out_direction_1 *= -1
	flipped.emit()
