extends Node2D

@onready var label_text := $Winner
@onready var map := $'../Map'

func _ready() -> void:
	Signals.connect("winner_text", Callable(self, "_on_winner_text"))

func _on_to_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_winner_text(winner: String):
	map.visible = false
	label_text.text = winner
	self.visible = true
