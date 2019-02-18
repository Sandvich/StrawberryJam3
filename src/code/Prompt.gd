extends AnimatedSprite

var key
var key_position
var file
var time
var active
var size
var time_passed

func start():
	active = true

func _input(event):
	if event.is_action_pressed(key):
		if active:
			get_node("../../Conductor").change_score(10)
		else:
			get_node("../../Conductor").change_score(-5)
		queue_free()

func missed():
	get_node("../../Conductor").change_score(-5)
	queue_free()

func _init(keypress, key_new_position, animation_file, actual):
	._init()
	key = keypress
	file = animation_file
	time = actual
	key_position = key_new_position
	size = 24

func _ready():
	set("frames", file)
	play(key)
	translate(key_position)
	active = false
	time_passed = 0
	set_process(true)

	# Add the timers
	var start_time = Timer.new()
	add_child(start_time)
	start_time.wait_time = time - 0.5 * globals.precision
	start_time.connect("timeout", self, "start")
	var end_time = Timer.new()
	add_child(end_time)
	end_time.wait_time = time + 0.5 * globals.precision
	end_time.connect("timeout", self, "missed")

	# Start the timers
	start_time.start()
	end_time.start()

func draw_empty_circle(radius):
	var draw_counter = 1
	var circle_radius = Vector2(radius, 0)
	var line_origin = Vector2(-radius, 0)
	var line_end = Vector2()
	var colour = Color("#FFFFFF")

	while draw_counter <= 360:
		line_end = circle_radius.rotated(deg2rad(draw_counter)) + Vector2(0,0)
		draw_line(line_origin, line_end, colour)
		draw_counter += 1
		line_origin = line_end

	line_end = circle_radius.rotated(deg2rad(360)) + Vector2(0,0)
	draw_line(line_origin, line_end, colour)

func _process(delta):
	time_passed += delta

func _draw():
	var resize = (time - time_passed)/time * size
	draw_empty_circle(size + resize)
