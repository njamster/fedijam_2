extends Area2D

@export var SPEED := 96 * 2 # pixels per second

@export var move_direction := Vector2.RIGHT:
	set(value):
		move_direction = value
		rotation = move_direction.angle()


func _process(delta: float) -> void:
	self.global_position += move_direction * SPEED * delta
