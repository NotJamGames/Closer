extends Node


var mouse_sensitivity : float = 1.0

var current_round : int = 1
var money : int = 4
var heads : int = 1
var closeness : int = 0


var odds : float = .5
var flips_since_last_head : int = 0


var heads_mod : int = 1
var cashback : int = 0
var divine_intervention : bool = false


var progress_round : bool


func _input(event : InputEvent) -> void:
	if event.is_action_pressed("quit_game") and not OS.get_name() == "Web":
		get_tree().quit()


func new_game() -> void:
	current_round = 1
	money = 4
	heads = 1

	closeness = 0

	odds = .5
	heads_mod = 1
	cashback = 0
	divine_intervention = false

	Powerups.possible_powerups.clear()
	Powerups.possible_powerups = Powerups.base_powerups.duplicate()


func new_round() -> void:
	if progress_round:
		current_round += 1
	money += 4
	heads = current_round

	Strings.lose_string_3_a["string"] = "You got to round %s" % current_round


func flip_coin() -> bool:
	# prevent too many consecutive tails results
	# so game feels a little fairer
	if flips_since_last_head > 4:
		flips_since_last_head = 0
		return true

	return randf() < odds


func set_heads_mod(new_value : int) -> void:
	heads_mod = new_value


func set_cashback(new_value : int) -> void:
	cashback = new_value


func set_odds(new_value : float) -> void:
	odds = new_value 


func set_divine_intervention(new_value : bool) -> void:
	divine_intervention = new_value
