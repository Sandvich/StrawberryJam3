extends Sprite

var timer
var image
var keypress

func _input(event):
	if event.is_action_pressed(keypress):
		get_node("../../Conductor").change_score(10)
		queue_free()

func missed():
	get_node("../../Conductor").change_score(-5)
	queue_free()

func _init(key, img):
	._init()
	image = img
	keypress = key
	self.position = Vector2(0, -100)

func _ready():
	set_texture(image)
	var timeout = Timer.new()
	add_child(timeout)
	timeout.wait_time = 0.5
	timeout.start()
	timeout.connect("timeout", self, "missed")
