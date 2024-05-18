extends Node2D

signal cell_pressed(cell: Node)

var cross_step := true
@export var lst_cells: Array 
var win_combinations := [
	[0, 1, 2],[3, 4, 5],[6, 7, 8],
	[0, 3, 6],[1, 4, 7],[2, 5, 8],
	[0, 4, 8],[2, 4, 6]
]


func _ready():
	pass


func _on_cell_pressed(cell: Node) -> void:
	if cross_step:
		cell.put_cross()
	else:
		cell.put_circle()
		
	cross_step = !cross_step

func is_victory() -> bool:
	for combination in win_combinations:
		var cross_winner: bool = lst_cells[0].is_cross()
		for i in combination:
			if lst_cells[i].is_empty(): break
		
	return true
	



