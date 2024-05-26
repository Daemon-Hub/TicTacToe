extends Node2D

@onready var animPl := $AnimationPlayer
@onready var options := $Options

var options_is_opened: bool = false

func _on_start_pressed() -> void:
	if options.check_btn_state:
		Global.game_state = 2
	else:
		Global.game_state = options.selected_person
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_options_btn_pressed() -> void:
	if !options_is_opened:
		animPl.play('options_open')
		options_is_opened = !options_is_opened
	else:
		animPl.play('options_close')
		options_is_opened = !options_is_opened






