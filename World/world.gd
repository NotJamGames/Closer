extends Node3D


@export var screen : MeshInstance3D
@export var subviewport : SubViewport
@export var screen_interface : Control
@export var blackout : ColorRect

@export var black_screen : Resource

@export var click_sfx : AudioStreamPlayer
@export var keystroke_sfx : AudioStreamPlayer
@export var power_outage_sfx : AudioStreamPlayer

@export var room_light : SpotLight3D

var user_input_enabled : bool = false : set = set_user_input_enabled


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

	screen.set_surface_override_material(0, black_screen)
	var timer : SceneTreeTimer = get_tree().create_timer(4.0)
	timer.timeout.connect\
			(screen.power_on)

	screen_interface.user_input_enabled.connect(set_user_input_enabled)
	screen_interface.event_requested.connect(trigger_event)
	screen_interface.crt_toggled.connect(screen.set_crt_active)


func _input(event: InputEvent) -> void:
	if user_input_enabled:
		if event is InputEventMouseButton and event.is_pressed():
			click_sfx.play()
		if event is InputEventKey and event.is_pressed():
			keystroke_sfx.play()

	subviewport.push_input(event)


func fade_in(duration : float) -> void:
	var tween : Tween = get_tree().create_tween()
	tween.tween_property(blackout, "color:a", .0, duration)\
			.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)


func trigger_event(event_ref : String) -> void:
	call(event_ref)


func set_user_input_enabled(new_state : bool) -> void:
	user_input_enabled = new_state


func power_out() -> void:
	room_light.power_out()
