extends Node3D


@export var subviewport : SubViewport


func _input(event: InputEvent) -> void:
	subviewport.push_input(event)
