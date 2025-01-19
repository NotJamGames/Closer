extends Control


@export var money_label : Label
@export var heads_label : Label


@export var info_panel : PanelContainer
@export var info_panel_elements : Array[Control]
@export var play_button : Button
@export var settings_button : TextureButton

const ELEMENT_INTERVAL : float = .12
@export var element_add_sfx : AudioStreamPlayer

const FLIP_INTERVAL = .33
@export var coin_slots : Array[CoinSlot]

var results_remaining : int = 4

@export var action_failure_sfx : AudioStreamPlayer
@export var win_jingle_sfx : AudioStreamPlayer

signal next_screen_requested()


func _ready() -> void:
	for coin_slot : CoinSlot in coin_slots:
		coin_slot.toggle_attempted.connect(check_coin_toggle)
		coin_slot.coin_flipped.connect(set_heads)


func configure_panel() -> void:
	visible = false

	results_remaining = 4

	for element : Control in info_panel_elements:
		element.modulate.a = .0

	for coin_slot : CoinSlot in coin_slots:
		coin_slot.toggle_state(false)

	var tween : Tween = get_tree().create_tween()
	tween.tween_method(set_info_panel_percent_visible, .0, 1.0, .36)

	set_buttons_disabled(false)

	visible = true

	var timer : SceneTreeTimer = get_tree().create_timer(ELEMENT_INTERVAL)
	timer.timeout.connect(add_panel_element)


func _on_settings_pressed() -> void:
	next_screen_requested.emit("settings_screen")


func set_info_panel_percent_visible(new_value : float) -> void:
	info_panel.material.set("shader_parameter/percent_visible", new_value)


func add_panel_element(element_ref : int = 0) -> void:
	if element_ref >= info_panel_elements.size(): return

	info_panel_elements[element_ref].modulate.a = 1.0
	element_add_sfx.pitch_scale = .5 + (float(element_ref) * .33)
	element_add_sfx.play()

	var timer : SceneTreeTimer = get_tree().create_timer(ELEMENT_INTERVAL)
	timer.timeout.connect(add_panel_element.bind(element_ref + 1))


func set_money(new_value : int) -> void:
	Global.money = new_value
	money_label.text = "%s¢" % new_value


func set_heads(result : int) -> void:
	Global.heads = max(Global.heads - result, 0)
	heads_label.text = "%s Heads" % Global.heads
	decrement_results_remaining()


func decrement_results_remaining() -> void:
	results_remaining -= 1
	if results_remaining == 0:
		var timer : SceneTreeTimer = get_tree().create_timer(.2)
		timer.timeout.connect(evaluate_result)


func set_buttons_disabled(new_state : bool) -> void:
	for coin_slot : CoinSlot in coin_slots:
		coin_slot.set_disabled(new_state)
	play_button.disabled = new_state
	settings_button.disabled = new_state


func check_coin_toggle(coin_slot : CoinSlot, new_state : bool) -> void:
	if new_state == false:
		set_money(Global.money + 1)
		coin_slot.toggle_state(new_state)
		return

	if Global.money <= 0:
		action_failure_sfx.play()
		return

	set_money(Global.money - 1)
	coin_slot.toggle_state(new_state)


func play() -> void:
	var coins_active : int = 0
	for coin_slot : CoinSlot in coin_slots:
		if coin_slot.texture_button.button_pressed:
			coins_active += 1

	if coins_active == 0:
		action_failure_sfx.play()
		return

	set_buttons_disabled(true)
	flip_coins()


func evaluate_result() -> void:
	if Global.heads == 0:
		win_jingle_sfx.play()
		var timer : SceneTreeTimer = get_tree().create_timer(.8)
		await timer.timeout
		next_screen_requested.emit\
				(
					"dialogue_screen", 
					["win_string_%s" % randi_range(0, Strings.win_strings)]
				)
	else:
		print("You lose")


func flip_coins(coin_index : int = 0) -> void:
	if coin_index >= 4: return
	coin_slots[coin_index].flip()

	var timer : SceneTreeTimer = get_tree().create_timer(FLIP_INTERVAL)
	timer.timeout.connect(flip_coins.bind(coin_index + 1))
