extends Control


@export var panel : PanelContainer

signal next_screen_requested()


func configure_shop() -> void:
	visible = false

	var tween : Tween = get_tree().create_tween()
	tween.tween_method(set_panel_percent_visible, .0, 1.0, .36)

	visible = true


func set_panel_percent_visible(new_value : float) -> void:
	panel.material.set("shader_parameter/x_percent_visible", new_value)


func next_round() -> void:
	Global.new_round()
	next_screen_requested.emit()
