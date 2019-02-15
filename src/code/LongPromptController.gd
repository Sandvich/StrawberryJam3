extends AnimatedSprite

var direction
var stick
var key
var key_position
var file
var time
var Conductor
var max_angle

func _input(event):
	var old_direction = direction
	var diff
	if stick == 0:
		# We're working with the left analog stick
		direction = Vector2(Input.get_joy_axis(0, JOY_AXIS_0), Input.get_joy_axis(0, JOY_AXIS_1))
		diff = old_direction.angle() - direction.angle()
	else:
		# We're working with the right
		direction = Vector2(Input.get_joy_axis(0, JOY_AXIS_2), Input.get_joy_axis(0, JOY_AXIS_3))
		diff = direction.angle() - old_direction.angle()

	if direction.length() >= 0.8:
		if 0 < diff and diff <= max_angle:
			Conductor.change_score(0.08)

func finished():
	queue_free()

func _init(keypress, key_new_position, animation_file, timeout):
	._init()
	if keypress.split("_")[0] == "left":
		stick = 0
	else:
		stick = 1
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
	timeout.connect("timeout", self, "finished")
	direction = Vector2(1, 0)
	Conductor = get_node("../../Conductor")
	max_angle = PI/4
