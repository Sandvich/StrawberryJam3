extends AudioStreamPlayer

func _ready():
	play()

func change_score(val):
	pass

func _on_Conductor_finished():
	play(0)
