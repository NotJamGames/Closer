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


var base_powerups : Array[String] = \
[
	"double_header", "cashback"
]
@onready var possible_powerups : Array[String] = base_powerups.duplicate()


func get_options() -> Array[Dictionary]:
	possible_powerups.shuffle()

	var options : Array[Dictionary] = []
	for i : int in 2:
		if i >= possible_powerups.size(): return options
		options.append(get(possible_powerups[i]))

	return options
