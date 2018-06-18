extends Sprite

var hasHeat = true

func _ready():
	$Area.connect("area_entered", self, "giveHeat")

func giveHeat(area):
	if area == get_node("../..").star && hasHeat:
		hasHeat = false
		$AudioStreamPlayer2D.play()
		get_node("../..").star.gainHeat(4.0)
		$Message.show()
		$Timer.connect("timeout", self, "blink")
		$Timer.start()

func blink():
	if $Message.visible:
		$Message.hide()
	else:
		$Message.show()