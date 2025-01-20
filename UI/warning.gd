extends Control


func _ready() -> void:
	if OS.is_debug_build():
		await get_tree().process_frame
		change_scene()
		return

	var timer : SceneTreeTimer = get_tree().create_timer(3.6)
	timer.timeout.connect(change_scene)


func change_scene() -> void:
	get_tree().change_scene_to_file("res://World/world.tscn")
