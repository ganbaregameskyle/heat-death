extends Sprite

onready var basePos = position

var hasHeat = true

func _ready():
	$Area.connect("area_entered", self, "giveHeat")
	$Tween.connect("tween_completed", self, "bounce")
	$SkullOrSquid.rotation = randf() * 0.4 - 0.2
	$Tween.interpolate_property($SkullOrSquid, "position", $SkullOrSquid.position, Vector2(140.0, 0.0).rotated(randf() * 2.0 * PI), 0.2 + 0.3 * randf(), Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.interpolate_property(self, "position", position, basePos + Vector2(128.0 + 512.0 * randf(), 0.0).rotated(randf() * 2.0 * PI), 8.0 + 16.0 * randf(), Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	$Tween.start()

func bounce(obj, key):
	if obj == $SkullOrSquid:
		$SkullOrSquid.rotation = randf() * 0.4 - 0.2
		$Tween.interpolate_property($SkullOrSquid, "position", $SkullOrSquid.position, Vector2(140.0, 0.0).rotated(randf() * 2.0 * PI), 0.2 + 0.3 * randf(), Tween.TRANS_LINEAR, Tween.EASE_OUT)
	else:
		$Tween.interpolate_property(self, "position", position, basePos + Vector2(128.0 + 512.0 * randf(), 0.0).rotated(randf() * 2.0 * PI), 8.0 + 16.0 * randf(), Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	
func giveHeat(area):
	if area == get_node("../..").star && hasHeat:
		hasHeat = false
		get_node("../..").star.gainHeat(4.0)