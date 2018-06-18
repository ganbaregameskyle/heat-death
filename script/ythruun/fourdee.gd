extends Sprite

var notSpinning = true

func _ready():
	$Area.connect("area_entered", self, "spin")
	$Viewport.set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	texture = $Viewport.get_texture()

func spin(area):
	if area == get_node("../..").star && notSpinning:
		notSpinning = false
		get_node("../..").star.gainHeat(4.0)
		$Tween.connect("tween_completed", self, "configTween")
		$Tween.interpolate_property($Viewport/Mesh, "rotation_degrees", $Viewport/Mesh.rotation_degrees, Vector3(360.0 * randf(), 360.0 * randf(), 360.0 * randf()), randf() * 2.0 + 2.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()

func configTween(obj, key):
	$Tween.interpolate_property($Viewport/Mesh, "rotation_degrees", $Viewport/Mesh.rotation_degrees, Vector3(360.0 * randf(), 360.0 * randf(), 360.0 * randf()), randf() * 2.0 + 2.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)