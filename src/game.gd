extends Node2D

enum {
	PLAYER,
	BOT,
	RANDOM
}

var state: int = 0:
	set(value):
		state = value
		match state:
			PLAYER: pass
			BOT: bots_turn()

@export var list_cells: Array

var player_step: int = Global.game_state
var win_combinations := [
	[0, 1, 2],[3, 4, 5],[6, 7, 8],
	[0, 3, 6],[1, 4, 7],[2, 5, 8],
	[0, 4, 8],[2, 4, 6]
]

func _ready() -> void:
	
	$End.visible = false 
	$Map.visible = true
	
	Global.connect("cell_pressed", Callable(self, "_on_cell_pressed"))
	
	for i in range(1, 10):
		list_cells.append(get_node("Map/Cells/Cell" + str(i)))
		
	if player_step == RANDOM:
		player_step = randi_range(0, 1)
	if player_step == 0:
		state = BOT
	else:
		state = PLAYER

func _on_cell_pressed(cell: Node) -> void:
	
	if player_step:
		cell.put_cross()
	else:
		cell.put_circle()
		
	check_victory_state()
		
	state = BOT
	
func check_victory_state():
	var res: String = is_victory()
	if res != "":
		Global.emit_signal("winner_text", res)
		
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

func bots_turn():
	var cells_state_list: Array[int] #Пустые ячейки
	for combination in win_combinations:
		var _empty: Array[int]
		var _cross: Array[int]
		var _circle: Array[int]
		for i in combination:
			if list_cells[i].is_empty():
				_empty.append(i)
				continue
			elif list_cells[i].is_cross():
				_cross.append(i)
				continue
			else:
				_circle.append(i)
		if len(_empty) == 0: continue
		if player_step:
#			if len(_cross) == 2 or len(_circle) == 2:
#				list_cells[_empty[0]].put_circle()
#			else:
			list_cells[choice(_empty)].put_circle()
			break
		else:
			list_cells[choice(_empty)].put_cross()
			break
	check_victory_state()
	state = PLAYER

func choice(arr: Array[int]) -> int:
	if len(arr) == 1:
		return arr[0]
	return arr[randi_range(0, len(arr)-1)]

