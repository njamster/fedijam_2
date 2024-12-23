extends TileMapLayer

@export var MAP_SIZE := Vector2i(54, 28)
@export var NUM_RANDOM_PATHS := 16

var branch_off_points := []
var rail_cells := []


func _ready() -> void:
	# place this tilemap layer at the center of the game window
	position = 0.5 * (DisplayServer.window_get_size() - MAP_SIZE * tile_set.tile_size)

	regenerate_map()


func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		match event.keycode:
			KEY_R:
				regenerate_map()
			KEY_SPACE:
				_add_random_path()
				set_cells_terrain_connect(rail_cells, 0, 0)


func regenerate_map() -> void:
	self.clear()
	rail_cells = []

	_generate_contour_path()

	for i in range(NUM_RANDOM_PATHS):
		_add_random_path()

	set_cells_terrain_connect(rail_cells, 0, 0)


func _generate_contour_path() -> void:
	branch_off_points = []

	var current_cell = Vector2(
		2 * randi_range(0, 1),
		2 * randi_range(0, 1)
	)
	rail_cells.append(current_cell)

	for x in range(MAP_SIZE.x - current_cell.x - 2 * randi_range(0, 1)):
		current_cell.x += 1
		rail_cells.append(current_cell)
		if int(current_cell.x) % 2 == 0 and randf() < 0.2:
			for i in range(2):
				current_cell.y += 1
				rail_cells.append(current_cell)

	for y in range(MAP_SIZE.y - current_cell.y - 2 * randi_range(0, 1)):
		current_cell.y += 1
		rail_cells.append(current_cell)
		if int(current_cell.y) % 2 == 0 and randf() < 0.2:
			for i in range(2):
				current_cell.x -= 1
				rail_cells.append(current_cell)

	for x in range(current_cell.x - 2 * randi_range(0, 1)):
		current_cell.x -= 1
		rail_cells.append(current_cell)
		if int(current_cell.x) % 2 == 0 and randf() < 0.2:
			for i in range(2):
				current_cell.y -= 1
				rail_cells.append(current_cell)

	for y in range(current_cell.y - 2 * randi_range(0, 1)):
		current_cell.y -= 1
		rail_cells.append(current_cell)
		if int(current_cell.y) % 2 == 0 and randf() < 0.2:
			for i in range(2):
				current_cell.x += 1
				rail_cells.append(current_cell)

	for cell in rail_cells:
		if cell.x > 0 and cell.x < MAP_SIZE.x and int(cell.x) % 2 == 0 and \
			cell.y > 0 and cell.y < MAP_SIZE.y and int(cell.y) % 2 == 0:
				branch_off_points.append(cell)


func _add_random_path() -> void:
	if not branch_off_points:
		return

	var current_cell = branch_off_points.pop_at(randi() % branch_off_points.size())

	rail_cells.append(current_cell)

	var loop_closed := false
	while not loop_closed:
		var STEP_SIZE := 2 * randi_range(1, 3) # cells

		var possible_directions := []
		for direction in [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]:
			var would_be_position = current_cell + STEP_SIZE * direction
			if would_be_position.x < 0 or would_be_position.x >= MAP_SIZE.x:
				continue # for loop with next direction
			if would_be_position.y < 0 or would_be_position.y >= MAP_SIZE.y:
				continue # for loop with next direction
			if not current_cell + direction in rail_cells:
				possible_directions.append(direction)

		if possible_directions:
			var random_direction = possible_directions.pick_random()
			for i in range(1, STEP_SIZE + 1):
				current_cell = current_cell + random_direction
				if current_cell in rail_cells:
					loop_closed = true
					break # for loop
				else:
					rail_cells.append(current_cell)
		else:
			break # while loop
