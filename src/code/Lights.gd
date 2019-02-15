extends Polygon2D

var colors
var size
var count

func _ready():
	set_process(false)
	colors = []
	colors.append(Color(255, 0, 0, 0.02))
	colors.append(Color(0, 255, 0, 0.02))
	colors.append(Color(0, 0, 255, 0.02))
	colors.append(Color(255, 255, 0, 0.02))
	colors.append(Color(0, 255, 255, 0.02))
	colors.append(Color(255, 0, 255, 0.02))
	size = colors.size()

func _process(delta):
	set_modulate(colors[randi() % size])
	
func change_color():
	set_modulate(colors[randi() % size])
