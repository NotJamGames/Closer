extends Control


@export var loading_screen : CenterContainer
@export var dialogue_screen : VBoxContainer
var current_screen : Control


func _ready() -> void:
	dialogue_screen.next_screen_requested.connect(set_screen)

	trigger_loading_screen(2.4, "dialogue_screen", ["intro_string_1"])


func set_screen(new_screen : String, args : Array = []) -> void:
	if current_screen != null:
		current_screen.visible = false

	current_screen = get(new_screen)
	if current_screen == null:
		push_error("Error: screen %s not found" % new_screen)
		return

	if current_screen == dialogue_screen:
		current_screen.initiate_dialogue(args[0])

	current_screen.visible = true


func trigger_loading_screen\
		(duration : float, next_screen : String,
		args : Array = []) -> void:
	set_screen("loading_screen")
	loading_screen.configure_load(duration)
	loading_screen.load_completed.connect\
			(set_screen.bind(next_screen, args))
