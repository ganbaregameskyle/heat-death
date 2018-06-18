extends Node2D

var hasHeat = true

func _ready():
	$Area.connect("area_entered", self, "giveHeat")

func giveHeat(area):
	if area == get_node("../..").star && hasHeat:
		hasHeat = false
		get_node("../..").star.gainHeat(4.0)
		$Tween.connect("tween_completed", self, "die")
		$Tween.interpolate_property($Head, "modulate", Color(1.0, 1.0, 1.0, 1.0), Color(1.0, 1.0, 1.0, 0.0), 2.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()

func die(obj, key):
	queue_free()