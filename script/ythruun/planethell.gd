extends Area2D

var alive = true

func _ready():
	connect("area_entered", self, "disappear")

func disappear(area):
	if area == get_node("../..").star && alive:
		get_node("../..").star.gainHeat(4.0)
		alive = false
		$AudioPlayer.play()
		$Tween.interpolate_property($Planet, "modulate", Color(1.0, 1.0, 1.0, 1.0), Color(1.0, 1.0, 1.0, 0.0), 4.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()