extends Node2D
class_name Level

enum LAYERS {
	GROUND,
	WALLS
}

const TILE_SIZE = Vector2i(8, 8)

@onready var tilemap: TileMap = %TileMap
@onready var character: Node2D = %Character


func _ready() -> void:
	character.cell = Vector2i(character.position) / TILE_SIZE


func is_cell_empty(cell: Vector2i) -> bool:
	return not cell in tilemap.get_used_cells(LAYERS.WALLS)


func _on_character_try_moving(dest_cell: Vector2i, move_callback: Callable) -> void:
	if is_cell_empty(dest_cell):
		move_callback.call()
