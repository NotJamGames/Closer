extends Control


@export var crt_effect_button : Button
var crt_effect_enabled : bool = true
var crt_button_strings : Array[String] = \
[
	"CRT Effect: Disabled",
	"CRT Effect: Enabled"
]

@export var quit_button : Button


signal crt_toggled()


func _ready() -> void:
	if OS.get_name() == "Web":
		quit_button.visible = false


func toggle_crt() -> void:
	crt_effect_enabled = not crt_effect_enabled
	crt_toggled.emit(crt_effect_enabled)
	crt_effect_button.text = crt_button_strings[int(crt_effect_enabled)]


func quit() -> void:
	get_tree().quit()
