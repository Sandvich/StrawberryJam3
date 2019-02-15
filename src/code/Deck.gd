extends AnimatedSprite

var anim_file
var valid_keys
var promptClass
var longPromptClass
var longPromptControllerClass
var key_positions
var using_controller

func _on_joy_connection_changed(device_id, connected):
	if connected:
		var name = Input.get_joy_name(device_id)
		print(name)
		if "DualShock" in name:
			print("Switching to playstation mapping.")
			using_controller = true
			anim_file = load("res://anim/ps.tres")
		elif ("XInput" in name) or ("XBox" in name):
			# Unfortunately, many devices declare themselves "XInput Device", instead of anything meaningful
			print("Switching to xbox mapping.")
			using_controller = true
			anim_file = load("res://anim/xbox.tres")
		else:
			print("Unknown device, defaulting to keyboard mapping.")
			using_controller = false
			anim_file = load("res://anim/keyboard.tres")
	else:
		print("Keyboard")
		using_controller = false
		anim_file = load("res://anim/keyboard.tres")

func _ready():
	# Set up input devices
	Input.connect("joy_connection_changed", self, "_on_joy_connection_changed")
	var devices = Input.get_connected_joypads()
	if devices.size() > 0:
		_on_joy_connection_changed(devices[0], true)
	else:
		_on_joy_connection_changed(null, false)

	# Set up class variables
	key_positions = {
		"left_deck_left": Vector2(-185,-30),
		"left_deck_right": Vector2(-65,-30),
		"left_deck_up": Vector2(-125,-70),
		"left_deck_down": Vector2(-125, 15),
		"left_analog_rotate": Vector2(-125, -32),
		"right_deck_left": Vector2(65, -30),
		"right_deck_right": Vector2(175, -30),
		"right_deck_up": Vector2(115, -70),
		"right_deck_down": Vector2(115, 15),
		"right_analog_rotate": Vector2(116, -32)
	}
	valid_keys = key_positions.keys()
	promptClass = load("res://code/Prompt.gd")
	longPromptClass = load("res://code/LongPrompt.gd")
	longPromptControllerClass = load("res://code/LongPromptController.gd")

func spawn(key, timeout, min_mash=null):
	if key in valid_keys:
		print("Spawning %s" % key)
		if key.ends_with("rotate"):
			if using_controller:
				add_child(longPromptControllerClass.new(key, key_positions[key], anim_file, timeout))
			else:
				add_child(longPromptClass.new(key, key_positions[key], anim_file, timeout, min_mash))
		else:
			add_child(promptClass.new(key, key_positions[key], anim_file, timeout))
	else:
		print("%s is not a valid prompt!" % key)
