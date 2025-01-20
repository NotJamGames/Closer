class_name PowerupButton
extends TextureButton


var data : Dictionary = {} : set = set_data


func _ready() -> void:
	toggle_mode = true


func set_data(new_data : Dictionary) -> void:
	if new_data == {}: return
	data = new_data.duplicate()
	set_textures(new_data["texture"])


func set_textures(new_texture : Texture) -> void:
	texture_normal = new_texture
	texture_pressed = new_texture
	texture_hover = new_texture
	texture_disabled = new_texture
	texture_focused = new_texture


func reset() -> void:
	data = {}
	set_textures(null)
