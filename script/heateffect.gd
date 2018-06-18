extends Particles2D

func _ready():
	$Timer.connect("timeout", self, "die")

func die():
	queue_free()