extends AudioStreamPlayer

var time = 0.0

func _ready():
	set_process(false)

func _process(delta):
	time += delta
	print(time)

func start():
	set_process(true)
	# play(0)
