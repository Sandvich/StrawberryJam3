extends AnimatedSprite

var anim_file
var valid_keys
var promptClass

func _on_joy_connection_changed(device_id, connected):
	if connected:
		var name = Input.get_joy_name(device_id)
		print(name)
		if "DualShock" in name:
			print("Switching to playstation mapping.")
			anim_file = load("res://anim/ps.tres")
		elif "XBox" in name:
			print("Switching to xbox mapping.")
			anim_file = load("res://anim/xbox.tres")
		else:
			print("Unknown device, defaulting to keyboard mapping.")
			anim_file = load("res://anim/keyboard.tres")
	else:
		print("Keyboard")
		anim_file = load("res://anim/keyboard.tres")

func _ready():
	Input.connect("joy_connection_changed", self, "_on_joy_connection_changed")

	var devices = Input.get_connected_joypads()
	if devices.size() > 0:
		_on_joy_connection_changed(devices[0], true)
	else:
		_on_joy_connection_changed(null, false)
	valid_keys = ["left_deck_left", "left_deck_right", "left_deck_up", "left_deck_down",
				"right_deck_left", "right_deck_right", "right_deck_up", "right_deck_down"]
	promptClass = load("res://code/Prompt.gd")

func prompt(key):
	if key in valid_keys:
		print("Spawn %s" % key)
		add_child(promptClass.new(key, anim_file))
	else:
		print("%s is not a valid prompt!" % key)
