extends Node2D

var alive = true

func _ready():
	$Timer.connect("timeout", self, "killLogo")
	$Timer.start()
	$Area0.connect("area_entered", self, "killTitle")
	$Area1.connect("area_entered", self, "killTitle")
	$Area2.connect("area_entered", self, "killTitle")
	$Area3.connect("area_entered", self, "killTitle")

func killLogo():
	$LogoAniPlayer.play("kill")
	$Timer.stop()

func killTitle(area):
	if area == get_node("../..").star && alive:
		alive = false
		$TitleAniPlayer.play("kill")