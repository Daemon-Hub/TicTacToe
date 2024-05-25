extends Node2D

enum {
	CROSS,
	CIRCLE,
	RANDOM
}
var state: int = int('res://files/game_state.txt'):
	set(value):
		state = value

@export var list_cells: Array

var cross_step
var win_combinations := [
	[0, 1, 2],[3, 4, 5],[6, 7, 8],
	[0, 3, 6],[1, 4, 7],[2, 5, 8],
	[0, 4, 8],[2, 4, 6]
]

func _ready() -> void:
	if state == RANDOM:
		state = randf_range(0, 1)
	$End.visible = false 
	$Map.visible = true
	Signals.connect("cell_pressed", Callable(self, "_on_cell_pressed"))
	for i in range(1, 10):
		list_cells.append(get_node("Map/Cells/Cell" + str(i)))
		
func _process(delta: float) -> void:
	if state:
		pass

func _on_cell_pressed(cell: Node) -> void:
	if cross_step:
		cell.put_cross()
	else:
		cell.put_circle()
	cross_step = !cross_step
	var res: String = is_victory()
	if res != "":
		Signals.emit_signal("winner_text", res)
	
func is_victory() -> String:
	var all_cells_is_fill: bool = true 
	for combination in win_combinations:
		var cnt: int = 0
		for i in combination:
			if list_cells[i].is_empty():
				if all_cells_is_fill:
					all_cells_is_fill = false
				break
			if list_cells[i].is_cross(): cnt += 1
			else: cnt -= 1
				
		if cnt == 3:
			return "Крестик победил!"
		elif cnt == -3:
			return "Нолик победил!"
	if all_cells_is_fill:
		return "Ничья!"
	return ""



