extends VBoxContainer


const NEW_STRING_DELAY : float = .48
const CHAR_INTERVAL : float = .08

var base_string : String = ""
var current_index : int = 0

var next_screen : String
var next_screen_args : Array

var dialogue_in_progress : bool = false
var skippable : bool = false

@export var rich_text_label : RichTextLabel

signal next_screen_requested()


func _input(event : InputEvent) -> void:
	if not (event is InputEventKey or event is InputEventMouseButton):
		return

	if skippable and visible:
		next_screen_requested.emit(next_screen, next_screen_args)

	elif dialogue_in_progress and event.is_pressed():
		complete_scroll()


func initiate_dialogue(string_ref : String) -> void:
	dialogue_in_progress = true
	skippable = false

	rich_text_label.text = ""
	current_index = 0

	var new_data : Dictionary = Strings.get(string_ref)

	base_string = new_data["string"]
	next_screen = new_data["next_screen"]
	next_screen_args = new_data["next_screen_args"]

	var timer : SceneTreeTimer = get_tree().create_timer(NEW_STRING_DELAY)
	timer.timeout.connect(scroll_text, CONNECT_ONE_SHOT)


func scroll_text() -> void:
	if not dialogue_in_progress: return

	current_index += 1
	if current_index > base_string.length():
		complete_scroll()
		return

	# TODO: play sfx
	var split_string : Array = \
			[
				base_string.left(current_index),
				base_string.right(base_string.length() - current_index)
			]
	rich_text_label.text = \
			"[center]%s[color=#071820]%s[/color][/center]" % \
					[split_string[0], split_string[1]]

	var timer : SceneTreeTimer = get_tree().create_timer(CHAR_INTERVAL)
	timer.timeout.connect(scroll_text, CONNECT_ONE_SHOT)


func complete_scroll() -> void:
	dialogue_in_progress = false

	rich_text_label.text = "[center]%s[/center]" % base_string
	var timer : SceneTreeTimer = get_tree().create_timer(.36)
	timer.timeout.connect(set.bind("skippable", true))
