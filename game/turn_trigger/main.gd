extends Area2D

@export var out_direction_1 : Vector2
@export var out_direction_2 : Vector2


func _on_area_entered(area: Area2D) -> void:
	var train := area.get_parent()
	if train.move_direction == -1 * self.out_direction_1:
		train.global_position = self.global_position
		train.move_direction = self.out_direction_2
	elif train.move_direction == -1 * self.out_direction_2:
		train.global_position = self.global_position
		train.move_direction = self.out_direction_1
