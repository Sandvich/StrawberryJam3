extends Node

var key_map
var valid_keys
var promptClass

func _ready():
	key_map = {
		"left_deck_up":load("res://assets/w.png"),
		"left_deck_left":load("res://assets/a.png"),
		"left_deck_down":load("res://assets/s.png"),
		"left_deck_right":load("res://assets/d.png"),
		"right_deck_left":load("res://assets/arrow_left.png"),
		"right_deck_right":load("res://assets/arrow_right.png"),
		"right_deck_up":load("res://assets/arrow_up.png"),
		"right_deck_down":load("res://assets/arrow_down.png")
	}
	valid_keys = key_map.keys()
	promptClass = load("res://code/Prompt.gd")

func prompt(key):
	if key in valid_keys:
		print("Spawn %s" % key)
		add_child(promptClass.new(key, key_map[key]))
	else:
		print("%s is not a valid prompt!" % key)
