extends Node


var double_header : Dictionary = \
{
	"title" : "DOUBLE HEADER",
	"description" : "Each head is worth two heads",
	"cost" : 2,
	"effect" : ["set_heads_mod", [2.0]],
	"unlock" : "triple_header",
	"texture" : preload("res://Powerups/Sprites/double_header.png")
}

var triple_header : Dictionary = \
{
	"title" : "TRIPLE HEADER",
	"description" : "Each head is worth three heads",
	"cost" : 3,
	"effect" : ["set_heads_mod", [3.0]],
	"texture" : preload("res://Powerups/Sprites/triple_header.png")
}

var cashback : Dictionary = \
{
	"title" : "CASHBACK",
	"description" : "Earn 1¢ per head",
	"cost" : 2,
	"effect" : ["set_cashback", [1]],
	"texture" : preload("res://Powerups/Sprites/cashback.png")
}

# slightly over the quoted odds here, feels better
var weighted_coins : Dictionary = \
{
	"title" : "WEIGHTED COINS",
	"description" : "2/3 chance of heads per flip",
	"cost" : 1,
	"effect" : ["set_odds", [.7]],
	"texture" : preload("res://Powerups/Sprites/weighted_coins.png")
}

var divine_intervention : Dictionary = \
{
	"title" : "DIVINE INTERVENTION",
	"description" : "Can't fail (one round only)",
	"cost" : 5,
	"effect" : ["set_divine_intervention", [true]],
	"texture" : preload("res://Powerups/Sprites/divine_intervention.png")
}


var base_powerups : Array[String] = \
[
	"double_header", "cashback", "weighted_coins", "divine_intervention",
	
]
@onready var possible_powerups : Array[String] = base_powerups.duplicate()


func get_options() -> Array[Dictionary]:
	possible_powerups.shuffle()

	var options : Array[Dictionary] = []
	for i : int in 3:
		if i >= possible_powerups.size(): return options
		options.append(get(possible_powerups[i]))

	return options
