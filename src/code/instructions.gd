extends RichTextLabel

var deck
var valid_keys
var num = 0

func _ready():
	deck = get_parent().get_node("Deck")
	valid_keys = deck.get("valid_keys")

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://main.tscn")

	if event.is_pressed():
		deck.spawn(valid_keys[num], 2)
		num += 1
		if num == valid_keys.size():
			num = 0
