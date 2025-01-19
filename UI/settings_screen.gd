extends Control


@export var crt_effect_button : Button
var crt_effect_enabled : bool = true
var crt_button_strings : Array[String] = \
[
	"CRT Effect: Disabled",
	"CRT Effect: Enabled"
]

@export var audio_button : Button
var audio_enabled : bool = true
var audio_button_strings : Array[String] = \
[
	"Audio: Disabled",
	"Audio: Enabled"
]

@export var quit_button : Button


signal crt_toggled()
signal next_screen_requested()


func _ready() -> void:
	if OS.get_name() == "Web":
		quit_button.visible = false


func toggle_crt() -> void:
	crt_effect_enabled = not crt_effect_enabled
	crt_toggled.emit(crt_effect_enabled)
	crt_effect_button.text = crt_button_strings[int(crt_effect_enabled)]


func toggle_audio() -> void:
	audio_enabled = not audio_enabled
	AudioServer.set_bus_mute(0, not audio_enabled)
	audio_button.text = audio_button_strings[int(audio_enabled)]


func back() -> void:
	next_screen_requested.emit("main_screen")


func quit() -> void:
	get_tree().quit()
