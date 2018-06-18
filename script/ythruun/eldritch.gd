extends Node2D

var hasHeat = true

func _ready():
	$Area.connect("area_entered", self, "enableGlitch")
	$Area.connect("area_exited", self, "disableGlitch")

func enableGlitch(area):
	if area == get_node("../..").star:
		area == get_node("../..").star.enableGlitch()
		if hasHeat:
			hasHeat = false
			get_node("../..").star.gainHeat(4.0)
			
func disableGlitch(area):
	if area == get_node("../..").star:
		area == get_node("../..").star.disableGlitch()
		if hasHeat:
			hasHeat = false
			get_node("../..").star.gainHeat(4.0)