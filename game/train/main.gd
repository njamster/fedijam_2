@tool
extends CharacterBody2D

@export var color := Color.WHITE:
	set(value):
		color = value
		if is_node_ready():
			$Sprite.modulate = color

@export var move_direction := Vector2.RIGHT:
	set(value):
		move_direction = value
		rotation = move_direction.angle()

var SPEED := 96 # pixels per second


func _ready() -> void:
	color = color


func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		return

	var collision:= move_and_collide(move_direction * SPEED * delta)
	if collision:
		queue_free()
