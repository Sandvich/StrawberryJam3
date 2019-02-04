extends AnimatedSprite

var playstation_map
var xbox_map
var keyboard_map
var key_map
var valid_keys
var promptClass

func _on_joy_connection_changed(device_id, connected):
	if connected:
		var name = Input.get_joy_name(device_id)
		print(name)
		if "DualShock" in name:
			print("Switching to playstation mapping.")
			key_map = playstation_map
		elif "XBox" in name:
			print("Switching to xbox mapping.")
			key_map = xbox_map
		else:
			print("Unknown device, defaulting to keyboard mapping.")
			key_map = keyboard_map
	else:
		print("Keyboard")
		key_map = keyboard_map

func _ready():
	Input.connect("joy_connection_changed", self, "_on_joy_connection_changed")
	keyboard_map = {
		"left_deck_up":load("res://assets/w.png"),
		"left_deck_left":load("res://assets/a.png"),
		"left_deck_down":load("res://assets/s.png"),
		"left_deck_right":load("res://assets/d.png"),
		"right_deck_left":load("res://assets/arrow_left.png"),
		"right_deck_right":load("res://assets/arrow_right.png"),
		"right_deck_up":load("res://assets/arrow_up.png"),
		"right_deck_down":load("res://assets/arrow_down.png")
	}
	playstation_map = {
		"left_deck_up":load("res://assets/w.png"),
		"left_deck_left":load("res://assets/a.png"),
		"left_deck_down":load("res://assets/s.png"),
		"left_deck_right":load("res://assets/d.png"),
		"right_deck_left":load("res://assets/arrow_left.png"),
		"right_deck_right":load("res://assets/arrow_right.png"),
		"right_deck_up":load("res://assets/arrow_up.png"),
		"right_deck_down":load("res://assets/arrow_down.png")
	}
	xbox_map = {
		"left_deck_up":load("res://assets/w.png"),
		"left_deck_left":load("res://assets/a.png"),
		"left_deck_down":load("res://assets/s.png"),
		"left_deck_right":load("res://assets/d.png"),
		"right_deck_left":load("res://assets/arrow_left.png"),
		"right_deck_right":load("res://assets/arrow_right.png"),
		"right_deck_up":load("res://assets/arrow_up.png"),
		"right_deck_down":load("res://assets/arrow_down.png")
	}
	
	var devices = Input.get_connected_joypads()
	if devices.size() > 0:
		_on_joy_connection_changed(devices[0], true)
	else:
		_on_joy_connection_changed(null, false)
	valid_keys = key_map.keys()
	promptClass = load("res://code/Prompt.gd")

func prompt(key):
	if key in valid_keys:
		print("Spawn %s" % key)
		add_child(promptClass.new(key, key_map[key]))
	else:
		print("%s is not a valid prompt!" % key)
