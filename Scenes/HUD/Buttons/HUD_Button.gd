@tool
extends TextureButton
class_name HUD_Button

const PRESSED_BUTTON_OFFSET = Vector2(0, 2)

enum DIRECTION {
	RIGHT,
	DOWN,
	LEFT,
	UP
}

@onready var top_texture: TextureRect = $TopTexture

@export var direction := DIRECTION.RIGHT:
	set(value):
		if value != direction:
			direction = value
			direction_changed.emit()

signal direction_changed


func _ready() -> void:
	direction_changed.connect(_update_texture)
	button_up.connect(_on_pressed_changed.bind(pressed))
	button_down.connect(_on_pressed_changed.bind(pressed))
	toggled.connect(_on_pressed_changed)
	
	_update_texture()


func _update_texture() -> void:
	var region_size = top_texture.texture.region.size
	
	top_texture.texture.set_region(Rect2(region_size * Vector2.RIGHT * direction, region_size))


func _on_pressed_changed(button_pressed: bool) -> void:
	var pos = PRESSED_BUTTON_OFFSET if button_pressed else Vector2.ZERO
	top_texture.set_position(pos)
