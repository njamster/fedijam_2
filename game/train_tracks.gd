extends TileMapLayer

const SOURCE_ID := 0

const CORNER_SE = Vector2i(0, 0)
const CORNER_SW = Vector2i(1, 0)
const CORNER_NE = Vector2i(0, 1)
const CORNER_NW = Vector2i(1, 1)

const HOR_SWITCH_SE = Vector2i(2, 0)
const HOR_SWITCH_SW = Vector2i(3, 0)
const HOR_SWITCH_NE = Vector2i(2, 1)
const HOR_SWITCH_NW = Vector2i(3, 1)

const VER_SWITCH_SE = Vector2i(4, 0)
const VER_SWITCH_SW = Vector2i(5, 0)
const VER_SWITCH_NE = Vector2i(4, 1)
const VER_SWITCH_NW = Vector2i(5, 1)

const TURN_TRIGGER := preload("res://game/turn_trigger/main.tscn")
const SWITCH := preload("res://game/switch/main.tscn")


func _ready() -> void:
	for cell in self.get_used_cells_by_id(SOURCE_ID, CORNER_SE):
		var turn_trigger := TURN_TRIGGER.instantiate()
		turn_trigger.position = self.map_to_local(cell)
		turn_trigger.out_direction_1 = Vector2.DOWN
		turn_trigger.out_direction_2 = Vector2.RIGHT
		add_child(turn_trigger)

	for cell in self.get_used_cells_by_id(SOURCE_ID, CORNER_SW):
		var turn_trigger := TURN_TRIGGER.instantiate()
		turn_trigger.position = self.map_to_local(cell)
		turn_trigger.out_direction_1 = Vector2.DOWN
		turn_trigger.out_direction_2 = Vector2.LEFT
		add_child(turn_trigger)

	for cell in self.get_used_cells_by_id(SOURCE_ID, CORNER_NE):
		var turn_trigger := TURN_TRIGGER.instantiate()
		turn_trigger.position = self.map_to_local(cell)
		turn_trigger.out_direction_1 = Vector2.UP
		turn_trigger.out_direction_2 = Vector2.RIGHT
		add_child(turn_trigger)

	for cell in self.get_used_cells_by_id(SOURCE_ID, CORNER_NW):
		var turn_trigger := TURN_TRIGGER.instantiate()
		turn_trigger.position = self.map_to_local(cell)
		turn_trigger.out_direction_1 = Vector2.UP
		turn_trigger.out_direction_2 = Vector2.LEFT
		add_child(turn_trigger)

	# --------------------------------------------------

	for cell in self.get_used_cells_by_id(SOURCE_ID, HOR_SWITCH_SE):
		var switch := SWITCH.instantiate()
		switch.position = self.map_to_local(cell)
		switch.out_direction_1 = Vector2.RIGHT
		switch.out_direction_2 = Vector2.DOWN
		switch.flipped.connect(_on_switch_flipped.bind(cell))
		add_child(switch)

	for cell in self.get_used_cells_by_id(SOURCE_ID, HOR_SWITCH_SW):
		var switch := SWITCH.instantiate()
		switch.position = self.map_to_local(cell)
		switch.out_direction_1 = Vector2.LEFT
		switch.out_direction_2 = Vector2.DOWN
		switch.flipped.connect(_on_switch_flipped.bind(cell))
		add_child(switch)

	for cell in self.get_used_cells_by_id(SOURCE_ID, HOR_SWITCH_NE):
		var switch := SWITCH.instantiate()
		switch.position = self.map_to_local(cell)
		switch.out_direction_1 = Vector2.RIGHT
		switch.out_direction_2 = Vector2.UP
		switch.flipped.connect(_on_switch_flipped.bind(cell))
		add_child(switch)

	for cell in self.get_used_cells_by_id(SOURCE_ID, HOR_SWITCH_NW):
		var switch := SWITCH.instantiate()
		switch.position = self.map_to_local(cell)
		switch.out_direction_1 = Vector2.LEFT
		switch.out_direction_2 = Vector2.UP
		switch.flipped.connect(_on_switch_flipped.bind(cell))
		add_child(switch)

	# --------------------------------------------------

	for cell in self.get_used_cells_by_id(SOURCE_ID, VER_SWITCH_SE):
		var switch := SWITCH.instantiate()
		switch.position = self.map_to_local(cell)
		switch.out_direction_1 = Vector2.DOWN
		switch.out_direction_2 = Vector2.RIGHT
		switch.flipped.connect(_on_switch_flipped.bind(cell))
		add_child(switch)

	for cell in self.get_used_cells_by_id(SOURCE_ID, VER_SWITCH_SW):
		var switch := SWITCH.instantiate()
		switch.position = self.map_to_local(cell)
		switch.out_direction_1 = Vector2.DOWN
		switch.out_direction_2 = Vector2.LEFT
		switch.flipped.connect(_on_switch_flipped.bind(cell))
		add_child(switch)

	for cell in self.get_used_cells_by_id(SOURCE_ID, VER_SWITCH_NE):
		var switch := SWITCH.instantiate()
		switch.position = self.map_to_local(cell)
		switch.out_direction_1 = Vector2.UP
		switch.out_direction_2 = Vector2.RIGHT
		switch.flipped.connect(_on_switch_flipped.bind(cell))
		add_child(switch)

	for cell in self.get_used_cells_by_id(SOURCE_ID, VER_SWITCH_NW):
		var switch := SWITCH.instantiate()
		switch.position = self.map_to_local(cell)
		switch.out_direction_1 = Vector2.UP
		switch.out_direction_2 = Vector2.LEFT
		switch.flipped.connect(_on_switch_flipped.bind(cell))
		add_child(switch)


func _on_switch_flipped(cell : Vector2i) -> void:
	match self.get_cell_atlas_coords(cell):
		HOR_SWITCH_SE:
			self.set_cell(cell, SOURCE_ID, HOR_SWITCH_SW)
		HOR_SWITCH_SW:
			self.set_cell(cell, SOURCE_ID, HOR_SWITCH_SE)
		HOR_SWITCH_NE:
			self.set_cell(cell, SOURCE_ID, HOR_SWITCH_NW)
		HOR_SWITCH_NW:
			self.set_cell(cell, SOURCE_ID, HOR_SWITCH_NE)
		VER_SWITCH_SE:
			self.set_cell(cell, SOURCE_ID, VER_SWITCH_NE)
		VER_SWITCH_SW:
			self.set_cell(cell, SOURCE_ID, VER_SWITCH_NW)
		VER_SWITCH_NE:
			self.set_cell(cell, SOURCE_ID, VER_SWITCH_SE)
		VER_SWITCH_NW:
			self.set_cell(cell, SOURCE_ID, VER_SWITCH_SW)
