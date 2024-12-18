extends Area2D

@export var out_direction_1 : Vector2
@export var out_direction_2 : Vector2


func _on_area_entered(area: Area2D) -> void:
	if area.move_direction == -1 * self.out_direction_1:
		area.global_position = self.global_position
		area.move_direction = self.out_direction_2
	elif area.move_direction == -1 * self.out_direction_2:
		area.global_position = self.global_position
		area.move_direction = self.out_direction_1
