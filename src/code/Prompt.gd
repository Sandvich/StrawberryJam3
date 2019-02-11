extends AnimatedSprite

var key
var key_position
var file
var time

func _input(event):
	if event.is_action_pressed(key):
		get_node("../../Conductor").change_score(10)
		queue_free()

func missed():
	get_node("../../Conductor").change_score(-5)
	queue_free()

func _init(keypress, key_new_position, animation_file, timeout):
	._init()
	key = keypress
	file = animation_file
	time = timeout
	key_position = key_new_position

func _ready():
	set("frames", file)
	play(key)
	translate(key_position)
	var timeout = Timer.new()
	add_child(timeout)
	timeout.wait_time = time
	timeout.start()
	timeout.connect("timeout", self, "missed")