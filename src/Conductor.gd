extends AudioStreamPlayer

var time = 0.0
var label
var time_decimal = [0, 0]
var time_string = "%dm %ds"
var leveldata
var spawner

func _ready():
	set_process(false)
	label = get_parent().get_node("time")
	spawner = get_parent().get_node("Spawner")
	var file = File.new()
	file.open("res://levels.json", file.READ)
	var output = JSON.parse(file.get_as_text())
	if output.error == OK:
		leveldata = output.result["easy"]
	file.close()
	print("Running level: easy")

func _process(delta):
	time += delta
	time_decimal[0] = floor(time/60)
	time_decimal[1] = floor(fmod(time, 60))
	label.set_text(time_string % time_decimal)
	while time >= leveldata[0][0]:
		spawner.prompt(leveldata[0][1])
		leveldata.pop_front()

func start():
	set_process(true)
	var deck = get_node("Deck")
	deck.play()
	play(0)
