extends MeshInstance3D


@export var crt_startup : AudioStreamPlayer


func power_on() -> void:
	crt_startup.play()

	mesh.material.set("shader_parameter/brightness", 8.0)
	set_surface_override_material(0, null)

	var tween : Tween = get_tree().create_tween()
	tween.tween_method\
			(set_brightness, mesh.material.get("shader_parameter/brightness"),
			1.0, 1.8).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)


func set_brightness(new_value : float) -> void:
	mesh.material.set("shader_parameter/brightness", new_value)


func set_crt_active(new_state : bool) -> void:
	mesh.material.set("shader_parameter/crt_enabled", new_state)
