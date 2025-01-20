extends Node


# TODO: handle automatic next screen
var atomic_font_path : String = "res://UI/Fonts/Not Jam Atomic 20.ttf"


var intro_string_1 : Dictionary = \
{
	"string" : "Are you feeling lucky?",
	"next_screen" : "dialogue_screen",
	"next_screen_args" : ["intro_string_2"]
}

var intro_string_2 : Dictionary = \
{
	"string" : "Heads: you win.",
	"next_screen" : "dialogue_screen",
	"next_screen_args" : ["intro_string_3"]
}

var intro_string_3 : Dictionary = \
{
	"string" : "Tails: I get...",
	"next_screen" : "dialogue_screen",
	"next_screen_args" : ["intro_string_4"]
}

var intro_string_4 : Dictionary = \
{
	"string" : "CLOSER.",
	"next_screen" : "main_screen",
	"next_screen_args" : [],
	"cue" : "power_out",
	"use_atomic_font" : true
}

var win_string_0 : Dictionary = \
{
	"string" : "You win... for now.",
	"next_screen" : "shop_screen",
	"next_screen_args" : []
}

var win_string_1 : Dictionary = \
{
	"string" : "You got lucky.",
	"next_screen" : "shop_screen",
	"next_screen_args" : []
}

var win_string_2 : Dictionary = \
{
	"string" : "Well played.",
	"next_screen" : "shop_screen",
	"next_screen_args" : []
}

var win_string_3 : Dictionary = \
{
	"string" : "Not bad.",
	"next_screen" : "shop_screen",
	"next_screen_args" : []
}

var win_string_4 : Dictionary = \
{
	"string" : "Let's play again.",
	"next_screen" : "shop_screen",
	"next_screen_args" : []
}

var win_strings : int = 4

var lose_string_1_a : Dictionary = \
{
	"string" : "That's not enough heads.",
	"next_screen" : "dialogue_screen",
	"next_screen_args" : ["lose_string_1_b"]
}

var lose_string_1_b : Dictionary = \
{
	"string" : "You know what that means.",
	"next_screen" : "dialogue_screen",
	"next_screen_args" : ["lose_string_1_c"]
}

var lose_string_1_c : Dictionary = \
{
	"string" : "CLOSER.",
	"next_screen" : "dialogue_screen",
	"next_screen_args" : ["lose_string_1_d"],
	"cue" : "lights_down_a",
	"use_atomic_font" : true
}

var lose_string_1_d : Dictionary = \
{
	"string" : "Let's continue.",
	"next_screen" : "shop_screen",
	"next_screen_args" : []
}

var lose_string_2_a : Dictionary = \
{
	"string" : "You disappoint me.",
	"next_screen" : "dialogue_screen",
	"next_screen_args" : ["lose_string_2_b"],
}

var lose_string_2_b : Dictionary = \
{
	"string" : "Ready or not...",
	"next_screen" : "dialogue_screen",
	"next_screen_args" : ["lose_string_2_c"]
}

var lose_string_2_c : Dictionary = \
{
	"string" : "HERE I COME",
	"next_screen" : "dialogue_screen",
	"next_screen_args" : ["lose_string_2_d"],
	"cue" : "lights_down_b",
	"use_atomic_font" : true
}

var lose_string_2_d : Dictionary = \
{
	"string" : "You have one more chance",
	"next_screen" : "shop_screen",
	"next_screen_args" : []
}


var lose_string_3_a : Dictionary = \
{
	"string" : "",
	"next_screen" : "dialogue_screen",
	"next_screen_args" : ["lose_string_3_b"],
}

var lose_string_3_b : Dictionary = \
{
	"string" : "I expected more.",
	"next_screen" : "dialogue_screen",
	"next_screen_args" : ["lose_string_3_c"],
}

var lose_string_3_c : Dictionary = \
{
	"string" : "Goodbye.",
	"next_screen" : "dialogue_screen",
	"cue" : "game_over",
	"next_screen_args" : ["lose_string_3_d"],
}

var lose_string_3_d : Dictionary = \
{
	"string" : "",
	"next_screen" : "dialogue_screen",	
	"next_screen_args" : ["lose_string_3_d"]
}


### POSSIBLE WARNING1 WARNINGS: ###
# That wasn't so lucky

#

### POSSIBLE WARNING2 WARNINGS: ###
# I'm close now
# I could almost reach out and touch you
# Still feeling lucky?
