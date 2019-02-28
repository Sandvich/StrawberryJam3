extends AudioStreamPlayer

var time = 0.0
var label
var time_decimal = [0, 0]
var time_string = "%dm %ds"
var leveldata
var bpm
var spawner
var score = 0
var scorelabel
var scoretext = "Score: %d"
var last_beat = 0
var lights

func _on_Conductor_finished():
	get_parent().get_node("end_screen").show()
	var scorelabel = get_parent().get_node("end_screen/final_score")
	scorelabel.set("text", scorelabel.text % score)

func _ready():
	# Basics
	set_process(false)
	label = get_parent().get_node("time")
	scorelabel = get_parent().get_node("score")
	spawner = get_parent().get_node("Deck")
	lights = get_parent().get_node("Lights")
	if globals.lights_off or globals.practice:
		lights.hide()
	else:
		lights.show()

	# Load JSON of our level
	var file = File.new()
	file.open("res://levels.json", file.READ)
	var output = JSON.parse(file.get_as_text())
	if output.error == OK:
		leveldata = output.result[globals.level]["level"]
		bpm = int(output.result[globals.level]["bpm"])
		stream = load(output.result[globals.level]["file"])
		globals.precision = float(output.result[globals.level]["precision"])*60/bpm
	file.close()
	print("Running level: %s" % globals.level)

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://main.tscn")

	# Timing Stuff
	time += delta
	var light_beat = floor((bpm*time)/15)
	var current_beat = floor(light_beat/4)
	time_decimal[0] = floor(time/60)
	time_decimal[1] = floor(fmod(time, 60))
	label.set_text(time_string % time_decimal)

	# Change the light colour regularly
	if light_beat > last_beat:
		last_beat = light_beat
		lights.change_color()

	# Spawn a new prompt
	while leveldata.size() > 0 and current_beat >= leveldata[0][0]:
		var timeout_beat = leveldata[0][2]*60/bpm
		spawner.spawn(leveldata[0][1], timeout_beat)
		leveldata.pop_front()

func start():
	set_process(true)
	spawner.play()
	play(0)

func change_score(scoredelta):
	score += scoredelta
	if score < 0:
		score = 0
	scorelabel.set_text(scoretext % score)
