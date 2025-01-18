extends Node3D


@export var subviewport : SubViewport


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN


func _input(event: InputEvent) -> void:
	subviewport.push_input(event)
