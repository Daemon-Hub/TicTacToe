extends Node2D

@export var game_state := 'res://files/game_state.txt'
@onready var person_option := $OptionButton
var state: int
var check_btn_state: bool

func _on_start_pressed() -> void:
	if check_btn_state:
		game_state = str(2)
	else:
		game_state = str(state)
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_check_button_toggled(button_pressed: bool) -> void:
	check_btn_state = button_pressed
	if button_pressed:
		person_option.disabled = true
		person_option.visible = false
	else:
		person_option.disabled = false
		person_option.visible = true
	
func _on_option_button_item_selected(index: int) -> void:
	state = index
