extends Node


var mouse_sensitivity : float = 1.0

var current_round : int = 1
var money : int = 4
var heads : int = 1


var odds : float = .5
var flips_since_last_head : int = 0


func new_game() -> void:
	current_round = 1
	money = 4
	heads = 1


func new_round() -> void:
	current_round += 1
	money += 4
	heads = current_round


func flip_coin() -> bool:
	# prevent to many consecutive tails results
	# so game feels a little fairer
	if flips_since_last_head > 3:
		flips_since_last_head = 0
		return true

	return randf() < odds
