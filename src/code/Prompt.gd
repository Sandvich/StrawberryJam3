extends AnimatedSprite

var timer
var key
var file
var time

func _input(event):
	if event.is_action_pressed(key):
		get_node("../../Conductor").change_score(10)
		queue_free()

func missed():
	get_node("../../Conductor").change_score(-5)
	queue_free()

func _init(keypress, animation_file, timeout):
	._init()
	key = keypress
	file = animation_file
	time = timeout

func _ready():
	set("frames", file)
	play(key)
	if key.begins_with("left"):
		translate(Vector2(-125,-30))
	elif key.begins_with("right"):
		translate(Vector2(115, -30))
	var timeout = Timer.new()
	add_child(timeout)
	timeout.wait_time = time
	timeout.start()
	timeout.connect("timeout", self, "missed")