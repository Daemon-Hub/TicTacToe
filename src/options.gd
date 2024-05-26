extends Area2D

@onready var person_option := $OptionButton

var selected_person: int = 0
var check_btn_state: bool = true

func _on_check_button_toggled(button_pressed: bool) -> void:
	print(button_pressed)
	check_btn_state = button_pressed
	if button_pressed:
		person_option.disabled = true
	else:
		person_option.disabled = false
			
func _on_option_button_item_selected(index: int) -> void:
	selected_person = index
