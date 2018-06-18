extends Area2D

var solid = true

func _ready():
	connect("area_entered", self, "erase")

func erase(area):
	if area == get_node("../../..").star && solid:
		solid = false
		$Tween.connect("tween_completed", self, "die")
		$Tween.interpolate_property($Sprite, "position", Vector2(0.0, 0.0), Vector2(64.0, 64.0), 1.0, Tween.TRANS_EXPO, Tween.EASE_OUT)
		$Tween2.interpolate_property($Sprite, "modulate", Color(1.0, 1.0, 1.0, 1.0), Color(1.0, 1.0, 1.0, 0.0), 1.0, Tween.TRANS_EXPO, Tween.EASE_OUT)
		$Tween.start()
		$Tween2.start()

func die(obj, key):
	get_parent().checkDead()
	queue_free()