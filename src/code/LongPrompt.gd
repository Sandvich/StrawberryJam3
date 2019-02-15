extends AnimatedSprite

var key
var key_position
var file
var time
var min_mashes
var actual_mashes = 0
var keymash_map
var alternate = 0

func _input(event):
	if event.is_action_pressed(keymash_map[key][alternate]):
		get_node("../../Conductor").change_score(1)
		alternate = 1 - alternate
		actual_mashes +=1

func finished():
	if min_mashes <= actual_mashes:
		get_node("../../Conductor").change_score(-10)
	queue_free()

func _init(keypress, key_new_position, animation_file, timeout, presses):
	._init()
	key = keypress
	file = animation_file
	time = timeout
	key_position = key_new_position
	min_mashes = presses

func _ready():
	set("frames", file)
	play(key)
	translate(key_position)
	var timeout = Timer.new()
	add_child(timeout)
	timeout.wait_time = time
	timeout.start()
	timeout.connect("timeout", self, "finished")
	keymash_map = {
		"left_analog_rotate": ["left_deck_left", "left_deck_right"],
		"right_analog_rotate": ["right_deck_left", "right_deck_right"]
	}
