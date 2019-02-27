extends CheckButton

var disabled_popup

func _ready():
	disabled_popup = get_node("LiveDisabled")

func _on_PracticeSelect_toggled(button_pressed):
	if not button_pressed:
		disabled_popup.popup_centered()

func _on_LiveDisabled_popup_hide():
	_toggled()
	# set("Toggle Mode", true)
	print(toggle_mode)
