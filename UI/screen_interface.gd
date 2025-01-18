extends Control


@export var loading_screen : CenterContainer
@export var dialogue_screen : VBoxContainer
@export var test_screen : Control
var current_screen : Control

@export var cursor : Sprite2D


func _ready() -> void:
	dialogue_screen.next_screen_requested.connect(set_screen)

	var timer : SceneTreeTimer = get_tree().create_timer(4.8)
	timer.timeout.connect\
			(trigger_loading_screen.bind\
					(2.4, "dialogue_screen", ["intro_string_1"]), \
					CONNECT_ONE_SHOT)


func _input(event : InputEvent) -> void:
	if event is InputEventMouseMotion:
		cursor.position = cursor.position + \
				(event.screen_relative * Global.mouse_sensitivity)
		cursor.position = cursor.position.clamp\
				(Vector2.ZERO, 
				Vector2(480.0, 360.0) - cursor.texture.get_size())


func set_screen(new_screen : String, args : Array = []) -> void:
	# TODO: hide cursor if not main screen

	if current_screen != null:
		current_screen.visible = false

	current_screen = get(new_screen)
	if current_screen == null:
		# TODO: move this to the right place
		cursor.visible = true
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
