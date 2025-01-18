extends Node3D


@export var screen : MeshInstance3D
@export var subviewport : SubViewport
@export var blackout : ColorRect

@export var black_screen : Resource


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

	screen.set_surface_override_material(0, black_screen)
	var timer : SceneTreeTimer = get_tree().create_timer(4.0)
	timer.timeout.connect\
			(screen.power_on)


func _input(event: InputEvent) -> void:
	subviewport.push_input(event)


func fade_in(duration : float) -> void:
	var tween : Tween = get_tree().create_tween()
	tween.tween_property(blackout, "color:a", .0, duration)\
			.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
