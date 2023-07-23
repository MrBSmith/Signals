extends Node2D
class_name Character

const MOVE_DURATION = 0.2

var input_directions = {
	"move_up": Vector2i.UP,
	"move_down": Vector2i.DOWN,
	"move_left": Vector2i.LEFT,
	"move_right": Vector2i.RIGHT
}

var cell = Vector2i.ZERO

signal try_moving(dest_cell: Vector2i, callback: Callable)


func _input(event: InputEvent) -> void:
	var direction = _get_input_movement_direction(event)
	
	if direction != Vector2i.ZERO:
		var dest_cell = cell + direction
		try_moving.emit(dest_cell, move.bind(dest_cell))


func move(dest_cell: Vector2i) -> void:
	var offset := Vector2(Level.TILE_SIZE) / 2.0
	var pos = Vector2(dest_cell * Level.TILE_SIZE) + offset
	var tween = create_tween()
	
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "position", pos, MOVE_DURATION)
	
	cell = dest_cell


func _get_input_movement_direction(event: InputEvent) -> Vector2i:
	for action_key in input_directions.keys():
		if event.is_action_pressed(action_key):
			return input_directions[action_key]
	
	return Vector2i.ZERO
