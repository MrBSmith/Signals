extends CanvasLayer
class_name HUD

@onready var move_buttons : Array[HUD_Button] = [%Up, %Left, %Right, %Down]


func _ready() -> void:
	for button in move_buttons:
		button.pressed.connect(_on_move_button_pressed.bind(button))


func _on_move_button_pressed(button: HUD_Button) -> void:
	var dir = Vector2i.ZERO
	
	match(button.direction):
		HUD_Button.DIRECTION.UP: dir = Vector2i.UP
		HUD_Button.DIRECTION.LEFT: dir = Vector2i.LEFT
		HUD_Button.DIRECTION.RIGHT: dir = Vector2i.RIGHT
		HUD_Button.DIRECTION.DOWN: dir = Vector2i.DOWN
	
	EVENTS.HUD_move_character.emit(dir)
