extends Area2D

const BOUND = 10240.0

var fast = false
var zoomTarget = 1.5
var moveAngle = 0.0
var speed = 512.0
var dots = []
var numYthruun = 0

func _ready():
	for d in $CanvasLayer/Dots.get_children():
		dots.append(d)
	$Camera/Tween.connect("tween_completed", self, "tweenDone")
	var z = zoomTarget + randf() * 0.4
	$Camera/Tween.interpolate_property($Camera, "zoom", $Camera.zoom, Vector2(z, z), 0.5 + randf() * 4.0, Tween.TRANS_EXPO, Tween.EASE_OUT)
	$Camera/Tween.interpolate_property($Camera, "rotation", $Camera.rotation, randf() * 0.4 - 0.2, 2.0 + randf() * 2.0, Tween.TRANS_EXPO, Tween.EASE_OUT)
	$Camera/Tween.start()

func enableGlitch():
	AudioServer.set_bus_effect_enabled(1, 0, true)
	$CanvasLayer/Glitch.show()

func disableGlitch():
	AudioServer.set_bus_effect_enabled(1, 0, false)
	$CanvasLayer/Glitch.hide()

func tweenHeat():
	if numYthruun == 16:
		AudioServer.set_bus_volume_db(0, -40.0)
		$Tween.interpolate_property($CanvasLayer/Fade, "modulate", Color(0.0, 0.0, 0.0, 0.6818), Color(0.0, 0.0, 0.0, 1.0), 2.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.interpolate_property($CanvasLayer/Thermometer/Mercury, "scale", Vector2(1.0, 0.0625), Vector2(1.0, 0.0), 2.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	else:
		AudioServer.set_bus_volume_db(0, -20.0 * numYthruun / 8.0)
		$Tween.interpolate_property($CanvasLayer/Fade, "modulate", Color(0.0, 0.0, 0.0, (numYthruun - 1.0) / 22.0), Color(0.0, 0.0, 0.0, numYthruun / 22.0), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.interpolate_property($CanvasLayer/Thermometer/Mercury, "scale", Vector2(1.0, 1.0 - (numYthruun - 1.0) / 16.0), Vector2(1.0, 1.0 - numYthruun / 16.0), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func gainHeat(h):
	get_parent().addEffect(position)
	$HeatPlayer.play()
	dots[numYthruun].show()
	numYthruun += 1
	tweenHeat()

func tweenDone(obj, key):
	if key.get_concatenated_subnames() == "zoom":
		var z = zoomTarget + randf() * 0.4
		$Camera/Tween.interpolate_property($Camera, "zoom", $Camera.zoom, Vector2(z, z), 0.5 + randf() * 4.0, Tween.TRANS_EXPO, Tween.EASE_OUT)
	elif key.get_concatenated_subnames() == "rotation":
		$Camera/Tween.interpolate_property($Camera, "rotation", $Camera.rotation, randf() * 0.4 - 0.2, 2.0 + randf() * 2.0, Tween.TRANS_EXPO, Tween.EASE_OUT)

func checkInput(event):
	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == 1:
				fast = true
				$Particles.amount = 32
				zoomTarget = 1.0
				var z = zoomTarget + randf() * 0.4
				$Camera/Tween.stop($Camera, "zoom")
				$Camera/Tween.interpolate_property($Camera, "zoom", $Camera.zoom, Vector2(z, z), 0.5 + randf() * 0.9, Tween.TRANS_EXPO, Tween.EASE_OUT)
		else:
			if event.button_index == 1:
				fast = false
				$Particles.amount = 16
				zoomTarget = 1.5
				var z = zoomTarget + randf() * 0.4
				$Camera/Tween.stop($Camera, "zoom")
				$Camera/Tween.interpolate_property($Camera, "zoom", $Camera.zoom, Vector2(z, z), 0.9 + randf() * 0.2, Tween.TRANS_EXPO, Tween.EASE_OUT)

func update(delta):
	if fast:
		if speed < 1280.0:
			speed += 3072.0 * delta
			if speed > 1280.0:
				speed > 1280.0
	else:
		if speed > 512.0:
			speed -= 2304.0 * delta
			if speed < 512.0:
				speed = 512.0
	var a = get_global_mouse_position().angle_to_point(get_global_position())
	moveAngle += 4.0 * delta * Vector2(1.0, 0.0).rotated(moveAngle).angle_to(Vector2(1.0, 0.0).rotated(a))
	if fast:
		$Sprite.rotation += 8.0 * delta
	else:
		$Sprite.rotation += 6.0 * delta
	position += Vector2(speed * delta, 0.0).rotated(moveAngle)
	$Camera.smoothing_enabled = true
	if position.x > BOUND:
		$Camera.smoothing_enabled = false
		position.x = -BOUND
	elif position.x < -BOUND:
		$Camera.smoothing_enabled = false
		position.x = BOUND
	if position.y > BOUND:
		$Camera.smoothing_enabled = false
		position.y = -BOUND
	elif position.y < -BOUND:
		$Camera.smoothing_enabled = false
		position.y = BOUND
	if $CanvasLayer/Thermometer/Mercury.scale.y <= 0.01:
		get_node("/root/global").setScene("res://scene/end.tscn")