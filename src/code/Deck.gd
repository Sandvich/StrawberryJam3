extends AnimatedSprite

var key_map
var anim_file
var valid_keys
var promptClass

func _on_joy_connection_changed(device_id, connected):
	var keyboard = false
	if connected:
		var name = Input.get_joy_name(device_id)
		print(name)
		if "DualShock" in name:
			print("Switching to playstation mapping.")
			key_map = {
				"left_deck_up": "dpad_up",
				"left_deck_down": "dpad_down",
				"left_deck_left": "dpad_left",
				"left_deck_right": "dpad_right",
				"right_deck_left":load("res://assets/arrow_left.png"),
				"right_deck_right":load("res://assets/arrow_right.png"),
				"right_deck_up":load("res://assets/arrow_up.png"),
				"right_deck_down":load("res://assets/arrow_down.png")
			}
			anim_file = load("res://assets/ps.tres")
		elif "XBox" in name:
			print("Switching to xbox mapping.")
			key_map = {
				"left_deck_up": "dpad_up",
				"left_deck_down": "dpad_down",
				"left_deck_left": "dpad_left",
				"left_deck_right": "dpad_right",
				"right_deck_left":load("res://assets/arrow_left.png"),
				"right_deck_right":load("res://assets/arrow_right.png"),
				"right_deck_up":load("res://assets/arrow_up.png"),
				"right_deck_down":load("res://assets/arrow_down.png")
			}
			anim_file = load("res://assets/xbox.tres")
		else:
			print("Unknown device, defaulting to keyboard mapping.")
			keyboard=true
	else:
		print("Keyboard")
		keyboard=true
	
	if keyboard:
		key_map = {
			"left_deck_up":"w",
			"left_deck_left":"a",
			"left_deck_down":"s",
			"left_deck_right":"d",
			"right_deck_left":"left",
			"right_deck_right":"right",
			"right_deck_up":"up",
			"right_deck_down":"down"
		}
		anim_file = load("res://assets/keyboard.tres")

func _ready():
	Input.connect("joy_connection_changed", self, "_on_joy_connection_changed")
	
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
		add_child(promptClass.new(key, anim_file, key_map[key]))
	else:
		print("%s is not a valid prompt!" % key)
