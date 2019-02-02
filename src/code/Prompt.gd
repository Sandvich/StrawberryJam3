extends Sprite

var timer
var image
var keypress

func _init(key, img):
	._init()
	image = img
	keypress = key
	self.position = Vector2(512, 100)

func _ready():
	set_texture(image)

func _input(event):
	if event.is_action_pressed(keypress):
		queue_free()
