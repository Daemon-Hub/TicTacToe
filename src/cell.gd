extends Area2D


@export var cross_path: NodePath
@export var circle_path: NodePath
@onready var cross: Sprite2D = get_node(cross_path)
@onready var circle: Sprite2D = get_node(circle_path)



func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if !is_instance_valid(cross) or !is_instance_valid(circle): return
	if cross.visible or circle.visible: return
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			get_parent().emit_signal("cell_pressed", self)
		
	
func put_cross():
	cross.visible = true

func put_circle():
	circle.visible = true

func is_cross() -> bool:
	return cross.visible

func is_empty() -> bool:
	return !cross.visible and !circle.visible
