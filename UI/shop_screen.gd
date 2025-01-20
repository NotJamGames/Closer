extends Control


@export var powerup_buttons : Array[PowerupButton]
var active_button : PowerupButton = null

@export var panel : PanelContainer

@export var main_panel : VBoxContainer
@export var powerup_panel : VBoxContainer
@onready var active_panel : VBoxContainer = main_panel

@export var hint_label : Label

@export var powerup_title_and_cost : Label
@export var powerup_description : Label

const MONEY_INTERVAL : float = .12
@export var money_label : Label
@export var money_add_sfx : AudioStreamPlayer

@export var action_failure_sfx : AudioStreamPlayer
@export var purchase_successful_sfx : AudioStreamPlayer

var num_powerups : int = 0

signal next_screen_requested()


func _ready() -> void:
	for button in powerup_buttons:
		button.pressed.connect(powerup_toggled.bind(button))


func configure_shop() -> void:
	visible = false

	var tween : Tween = get_tree().create_tween()
	tween.tween_method(set_panel_percent_visible, .0, 1.0, .36)

	var start_money : int = Global.money
	money_label.text = "%s¢" % start_money

	Global.new_round()
	var timer : SceneTreeTimer = get_tree().create_timer(.5)
	timer.timeout.connect(increment_money.bind(start_money + 1))

	populate_powerups()

	visible = true


func set_panel_percent_visible(new_value : float) -> void:
	panel.material.set("shader_parameter/x_percent_visible", new_value)


func populate_powerups() -> void:
	num_powerups = 0
	var powerup_data : Array[Dictionary] = Powerups.get_options()
	if powerup_data.size() == 0:
		hint_label.text = "The shop is sold out"
	else:
		hint_label.text = "Select a powerup to view details"

	for i : int in powerup_buttons.size():
		var powerup_button : TextureButton = powerup_buttons[i]
		powerup_button.modulate.a = 1.0

		if i >= powerup_data.size():
			powerup_button.reset()
			powerup_button.visible = false
			continue

		num_powerups += 1
		powerup_button.set_data(powerup_data[i])
		powerup_button.visible = true


func next_round() -> void:
	next_screen_requested.emit()


func set_active_panel(new_panel : VBoxContainer) -> void:
	active_panel.visible = false
	active_panel = new_panel
	active_panel.visible = true


func powerup_toggled(powerup : PowerupButton = null) -> void:
	if powerup == null or active_panel == powerup_panel:
		for powerup_button : PowerupButton in powerup_buttons:
			powerup_button.modulate.a = 1.0
		set_active_panel(main_panel)
		return

	if active_panel == main_panel:
		active_button = powerup
		set_active_panel(powerup_panel)

		active_button = powerup
		powerup_title_and_cost.text = \
				"%s - %s¢" % [powerup.data["title"], powerup.data["cost"]]
		powerup_description.text = powerup.data["description"]

		for powerup_button : PowerupButton in powerup_buttons:
			powerup_button.modulate.a = \
					1.0 * float(powerup_button == active_button)


func purchase_requested() -> void:
	var powerup_data : Dictionary = active_button.data.duplicate()
	if Global.money < powerup_data["cost"]:
		action_failure_sfx.play()
		return

	Global.money -= powerup_data["cost"]
	active_button.visible = false
	set_active_panel(main_panel)
	Global.callv(powerup_data["effect"][0], powerup_data["effect"][1])
	purchase_successful_sfx.play()

	if powerup_data.keys().has("unlock"):
		Powerups.possible_powerups.append(powerup_data["unlock"])

	var powerup_var_name : String = powerup_data["title"]
	powerup_var_name = powerup_var_name.to_snake_case()
	Powerups.possible_powerups.erase(powerup_var_name)

	money_label.text = "%s¢" % Global.money
	for powerup_button : PowerupButton in powerup_buttons:
			powerup_button.modulate.a = 1.0

	num_powerups -= 1
	if num_powerups == 0:
		hint_label.text = "The shop is sold out"


func increment_money(start_value : int) -> void:
	if start_value > Global.money: return

	money_label.text = "%s¢" % start_value
	money_add_sfx.play()

	var timer : SceneTreeTimer = get_tree().create_timer(MONEY_INTERVAL)
	timer.timeout.connect(increment_money.bind(start_value + 1))
