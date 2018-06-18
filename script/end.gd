extends Node2D

func _ready():
	$Button.connect("button_up", self, "quit")
	set_process_input(true)

func _input(event):
	if event.is_action("escape"):
		quit()

func quit():
	get_tree().quit()