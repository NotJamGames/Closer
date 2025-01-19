extends Control


@export var info_panel : PanelContainer
@export var info_panel_elements : Array[Control]

const ELEMENT_INTERVAL : float = .12
@export var element_add_sfx : AudioStreamPlayer

signal next_screen_requested()


func configure_panel() -> void:
	visible = false

	for element : Control in info_panel_elements:
		element.modulate.a = .0

	var tween : Tween = get_tree().create_tween()
	tween.tween_method(set_info_panel_percent_visible, .0, 1.0, .36)

	visible = true

	var timer : SceneTreeTimer = get_tree().create_timer(ELEMENT_INTERVAL)
	timer.timeout.connect(add_panel_element)


func _on_settings_pressed() -> void:
	next_screen_requested.emit("settings_screen")


func set_info_panel_percent_visible(new_value : float) -> void:
	info_panel.material.set("shader_parameter/percent_visible", new_value)


func add_panel_element(element_ref : int = 0) -> void:
	if element_ref >= info_panel_elements.size(): return

	info_panel_elements[element_ref].modulate.a = 1.0
	element_add_sfx.pitch_scale = .5 + (float(element_ref) * .33)
	element_add_sfx.play()

	var timer : SceneTreeTimer = get_tree().create_timer(ELEMENT_INTERVAL)
	timer.timeout.connect(add_panel_element.bind(element_ref + 1))
