extends Area2D

var hasHeat = true

func _ready():
	connect("area_entered", self, "giveHeat")

func giveHeat(area):
	if area == get_node("../..").star && hasHeat:
		hasHeat = false
		get_node("../..").star.gainHeat(4.0)
		$AniPlayer.play("die")