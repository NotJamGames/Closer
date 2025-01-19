extends SpotLight3D


@export var base_energy_range : Array[float]
@export var base_energy_frequency : float
var current_base_energy : float = 1.0
var current_base_index : int = 0


@export var flicker_energy_range : Array[float]
@export var flicker_frequency : float
var current_flicker_energy : float = .0
var current_flicker_index : int = 0

var light_mod : float = 1.0
var power_is_out : bool = false
var power_out_duration : float = 1.6
var min_power_out_flicker : float = .04
var max_power_out_flicker : float = .12


func _ready() -> void:
	update_base_energy()
	update_flicker_energy()


func _process(_delta : float) -> void:
	light_energy = (current_base_energy + current_flicker_energy) * light_mod


func update_base_energy() -> void:
	current_base_index = wrapi(current_base_index + 1, 0, 2)
	var tween : Tween = get_tree().create_tween()
	tween.tween_property\
			(self, "current_base_energy",
			base_energy_range[current_base_index], base_energy_frequency)
	tween.finished.connect(update_base_energy, CONNECT_ONE_SHOT)


func update_flicker_energy() -> void:
	current_flicker_index = wrapi(current_flicker_index + 1, 0, 2)
	var tween : Tween = get_tree().create_tween()
	tween.tween_property\
			(self, "current_flicker_energy", 
			flicker_energy_range[current_flicker_index], flicker_frequency)
	tween.finished.connect(update_flicker_energy, CONNECT_ONE_SHOT)


func power_out() -> void:
	power_is_out = true
	var timer : SceneTreeTimer = get_tree().create_timer(power_out_duration)
	timer.timeout.connect(set.bind("power_is_out", false))

	# TODO: play sfx
	power_out_flicker()


func power_out_flicker() -> void:
	if not power_is_out:
		light_mod = 1.0
		return

	light_mod = abs(light_mod - 1.0)
	var timer : SceneTreeTimer = get_tree().create_timer\
			(randf_range(min_power_out_flicker, max_power_out_flicker))
	timer.timeout.connect(power_out_flicker)
