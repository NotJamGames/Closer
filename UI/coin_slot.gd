class_name CoinSlot
extends PanelContainer


signal toggle_attempted()
signal coin_flipped()


@export var empty_resource : Resource
@export var tails_resource : Resource
@export var heads_resource : Resource

@onready var texture_resources : Array[Resource] = \
		[empty_resource, tails_resource, heads_resource]

@export var flip_start_sfx : AudioStreamPlayer
@export var flip_results_sfx : Array[AudioStreamPlayer]

@export var texture_button : TextureButton
@export var animated_sprite : AnimatedSprite2D

var disabled : bool = false


func _ready() -> void:
	toggle_state(false)


func attempt_toggle(new_state : bool) -> void:
	if disabled: return
	toggle_attempted.emit(self, new_state)


func toggle_state(new_state : bool) -> void:
	set_textures(texture_resources[int(new_state) * 2])


func reset() -> void:
	disabled = true
	set_textures(empty_resource)
	texture_button.button_pressed = false
	disabled = false


func set_disabled(new_state : bool) -> void:
	texture_button.disabled = new_state


func flip() -> void:
	if not texture_button.button_pressed:
		coin_flipped.emit(false)
		return

	texture_button.visible = false
	animated_sprite.visible = true
	animated_sprite.play("Flip")
	flip_start_sfx.play()
	await animated_sprite.animation_finished

	animated_sprite.visible = false
	var result : bool = Global.flip_coin()
	set_textures(texture_resources[int(result) + 1])
	texture_button.visible = true
	flip_results_sfx[int(result)].play()
	coin_flipped.emit(result)


func set_textures(new_texture : Resource) -> void:
	texture_button.texture_normal = new_texture
	texture_button.texture_pressed = new_texture
	texture_button.texture_hover = new_texture
	texture_button.texture_disabled = new_texture
	texture_button.texture_focused = new_texture
