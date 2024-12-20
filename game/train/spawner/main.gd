extends Marker2D

const TRAIN_SCENE := preload("res://game/train/main.tscn")

@export var spawn_direction := Vector2.RIGHT

@export_range(1, 60, 1, "suffix:s") var wait_time := 5.0


func _ready() -> void:
	$Cooldown.timeout.connect(_on_timeout)
	$Cooldown.wait_time = wait_time
	$Cooldown.start()
	_on_timeout()


func _on_timeout() -> void:
	var train := TRAIN_SCENE.instantiate()
	train.global_position = self.global_position
	train.move_direction = spawn_direction
	train.top_level = true
	add_child(train)
