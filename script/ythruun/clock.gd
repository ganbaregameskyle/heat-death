extends Area2D

var stopped = true

func _ready():
	connect("area_entered", self, "startClock")

func startClock(area):
	if area == get_node("../..").star && stopped:
		stopped = false
		get_node("../..").star.gainHeat(4.0)
		$AniPlayer.play("base")
		$Tween.connect("tween_completed", self, "resetClock")
		$Tween.interpolate_property($Face/Minute, "rotation", 0.0, PI * 8.0, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.interpolate_property($Face/Hour, "rotation", 0.0, PI * 8.0, 60.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()

func resetClock(obj, key):
	if obj == $Face/Minute:
		$Tween.interpolate_property($Face/Minute, "rotation", 0.0, PI * 8.0, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	elif obj == $Face/Hour:
		$Tween.interpolate_property($Face/Hour, "rotation", 0.0, PI * 8.0, 60.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)