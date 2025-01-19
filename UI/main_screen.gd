extends Control


signal next_screen_requested()


func _on_settings_pressed() -> void:
	next_screen_requested.emit("settings_screen")
