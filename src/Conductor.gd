extends AudioStreamPlayer

var time = 0.0
var label
var time_decimal = [0, 0]
var time_string = "%dm %ds"

func _ready():
	set_process(false)
	label = get_parent().get_node("time")

func _process(delta):
	time += delta
	time_decimal[0] = floor(time/60)
	time_decimal[1] = floor(fmod(time, 60))
	label.set_text(time_string % time_decimal)

func start():
	set_process(true)
	play(0)
