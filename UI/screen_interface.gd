extends Control


@export var loading_screen : CenterContainer
var current_screen : Control


func _ready() -> void:
	trigger_loading_screen(2.4, "")


func set_screen(new_screen : String) -> void:
	if current_screen != null:
		current_screen.visible = false

	current_screen = get(new_screen)
	if current_screen == null:
		push_error("Error: screen %s not found" % new_screen)
		return
	current_screen.visible = true


func trigger_loading_screen(duration : float, next_screen : String) -> void:
	set_screen("loading_screen")
	loading_screen.configure_load(duration)
	loading_screen.load_completed.connect(set_screen.bind(next_screen))
