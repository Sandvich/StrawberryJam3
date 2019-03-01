extends TextureRect

var levels
var current_level
var level_label

func start_level():
	var optionRoot = get_node("CenterContainer/VBoxContainer")
	var options = {
		"practice": optionRoot.get_node("PracticeSelect").pressed,
		"lights_off": optionRoot.get_node("LightsSelect").pressed,
		"level": current_level
	}
	for item in options.keys():
		globals.set(item, options[item])
	get_tree().change_scene("res://game.tscn")

func change_level(move_by):
	var num_levels = levels.size()
	current_level += move_by
	if current_level < 0:
		current_level = num_levels - 1
	elif current_level == num_levels:
		current_level = 0
	level_label.text = levels[current_level]

func _input(event):
	if Input.is_action_just_pressed("ui_left"):
		change_level(-1)
	elif Input.is_action_just_pressed("ui_right"):
		change_level(1)
	elif Input.is_action_just_pressed("ui_accept"):
		start_level()
	elif Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func _ready():
	# Parse the levels we have to choose from
	levels = []
	for entry in globals.levels:
		levels.append("%s: %s by %s" % [entry.get("difficulty"), entry.get("songname"), entry.get("artist")])
	print("Available levels: " + str(levels))

	# Set the label so that the correct level is shown on-screen
	current_level = 0
	level_label = get_node("CenterContainer/VBoxContainer/LevelSelect/LevelLabel")
	change_level(0)

func _on_Prev_pressed():
	change_level(-1)

func _on_Next_pressed():
	change_level(1)
