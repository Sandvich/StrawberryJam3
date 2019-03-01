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
var crowd

func _on_Conductor_finished():
	get_parent().get_node("end_screen").show()
	var scorelabel = get_parent().get_node("end_screen/final_score")
	scorelabel.set("text", scorelabel.text % score)

func _ready():
	# Load level data
	leveldata = globals.get_level(globals.level).get("code").duplicate()
	bpm = globals.get_level(globals.level).get("bpm")
	stream = load(globals.get_level(globals.level).get("file"))
	globals.precision = float(globals.get_level(globals.level).get("precision")*60/bpm)
	#print(globals.get_level(globals.level).get("code"))

	# Basics
	set_process(false)
	label = get_parent().get_node("time")
	scorelabel = get_parent().get_node("score")
	spawner = get_parent().get_node("Deck")
	lights = get_parent().get_node("Lights")
	crowd = get_parent().get_node("crowd")
	if globals.lights_off:
		lights.hide()
	if globals.practice:
		crowd.hide()
		lights.hide()
	else:
		for member in crowd.get_children():
			member.frames.set_animation_speed("default", bpm/15)

	print("Running level: %s" % globals.level)

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://main.tscn")

	# Timing Stuff
	time += delta
	var light_beat = floor((bpm*time)/15)
	var current_beat = floor((bpm*time)/60)
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
	if not globals.practice:
		for person in crowd.get_children():
			person.play()

func change_score(scoredelta):
	score += scoredelta
	if score < 0:
		score = 0
	scorelabel.set_text(scoretext % score)
