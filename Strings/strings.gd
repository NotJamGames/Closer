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



### POSSIBLE WARNING1 WARNINGS: ###
# That wasn't so lucky

#

### POSSIBLE WARNING2 WARNINGS: ###
# I'm close now
# I could almost reach out and touch you
# Still feeling lucky?
