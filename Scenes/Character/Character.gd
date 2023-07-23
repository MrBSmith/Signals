extends Node2D
class_name Character

var input_directions = {
	"move_up": Vector2i.UP,
	"move_down": Vector2i.DOWN,
	"move_left": Vector2i.LEFT,
	"move_right": Vector2i.RIGHT
}

var cell = Vector2i.ZERO


func _input(event: InputEvent) -> void:
	var direction = _get_input_movement_direction(event)


func _get_input_movement_direction(event: InputEvent) -> Vector2i:
	for action_key in input_directions.keys():
		if event.is_action_pressed(action_key):
			return input_directions[action_key]
	
	return Vector2i.ZERO
