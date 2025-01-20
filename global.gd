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


func new_game() -> void:
	current_round = 1
	money = 4
	heads = 1

	closeness = 0

	Powerups.possible_powerups.clear()
	Powerups.possible_powerups = Powerups.base_powerups.duplicate()


func new_round() -> void:
	current_round += 1
	money += 4
	heads = current_round


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
