extends Node3D


@export var screen : MeshInstance3D
@export var subviewport : SubViewport
@export var screen_interface : Control
@export var blackout : ColorRect

@export var black_screen : Resource

@export var animation_player : AnimationPlayer

@export var click_sfx : AudioStreamPlayer
@export var keystroke_sfx : AudioStreamPlayer
@export var power_outage_sfx : AudioStreamPlayer
@export var footsteps_running : AudioStreamPlayer3D
@export var ambience_2 : AudioStreamPlayer
@export var ambience_3 : AudioStreamPlayer

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

	Global.new_game()


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


func fade_out() -> void:
	var tween : Tween = get_tree().create_tween()
	tween.tween_property(blackout, "color:a", 1.0, 2.2)\
			.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)


func trigger_event(event_ref : String) -> void:
	call(event_ref)


func set_user_input_enabled(new_state : bool) -> void:
	user_input_enabled = new_state


func power_out() -> void:
	room_light.power_out()


func lights_down_a() -> void:
	ambience_2.play()
	room_light.spot_angle = 33.0
	room_light.power_out()


func lights_down_b() -> void:
	room_light.light_color = Color(1.0, .0, .0, 1.0)
	room_light.power_out()

	await get_tree().create_timer(1.2).timeout

	ambience_3.play()
	footsteps_running.play()
	animation_player.play("GlanceLeft")
	var tween : Tween = get_tree().create_tween()
	tween.tween_property(footsteps_running, "position:z", 3.7, 1.4)


func game_over() -> void:
	room_light.power_out()
	user_input_enabled = false
	await get_tree().create_timer(.5).timeout
	animation_player.play("Death")


func reload() -> void:
	get_tree().reload_current_scene()
