extends Area2D

var alive = true

func _ready():
	connect("area_entered", self, "slumber")

func slumber(area):
	if area == get_node("../..").star && alive:
		get_node("../..").star.gainHeat(4.0)
		$AniPlayer.play("slumber")
		alive = false