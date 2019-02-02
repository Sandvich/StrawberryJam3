extends AudioStreamPlayer

var time = 0.0
var label
var time_decimal = [0, 0]
var time_string = "%dm %ds"
var leveldata

func _ready():
	set_process(false)
	label = get_parent().get_node("time")
	var file = File.new()
	file.open("res://levels.json", file.READ)
	var output = JSON.parse(file.get_as_text())
	if output.error == OK:
		leveldata = output.result["easy"]
	file.close()

func _process(delta):
	time += delta
	time_decimal[0] = floor(time/60)
	time_decimal[1] = floor(fmod(time, 60))
	label.set_text(time_string % time_decimal)
	if leveldata.size() > 0:
		if time >= leveldata[0][0]:
			print("spawn a " + leveldata[0][1])
			leveldata.pop_front()

func start():
	set_process(true)
	var deck = get_node("Deck")
	deck.play()
	play(0)
