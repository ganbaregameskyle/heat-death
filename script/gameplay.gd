extends Node2D

var starClass = preload("res://scene/star.tscn")
var effectClass = preload("res://scene/heateffect.tscn")
var ythruunClasses = [preload("res://scene/ythruun/ythruun.tscn"), preload("res://scene/ythruun/lastone.tscn"), 
						preload("res://scene/ythruun/bubble.tscn"), preload("res://scene/ythruun/distortionzone.tscn"), 
						preload("res://scene/ythruun/planethell.tscn"), preload("res://scene/ythruun/spacemist.tscn"),
						preload("res://scene/ythruun/thirdeye.tscn"), preload("res://scene/ythruun/juliasystem.tscn"), 
						preload("res://scene/ythruun/fourdee.tscn"), preload("res://scene/ythruun/billboard.tscn"), 
						preload("res://scene/ythruun/goddess.tscn"), preload("res://scene/ythruun/eldritch.tscn"),
						preload("res://scene/ythruun/hand.tscn"), preload("res://scene/ythruun/clock.tscn"), 
						preload("res://scene/ythruun/eyestar.tscn"), preload("res://scene/ythruun/theinternet.tscn")]

var star = null

func _ready():
	randomize()
	var title = load("res://scene/ythruun/title.tscn").instance()
	$YthruunNode.add_child(title)
	ythruunClasses = shuffleList(ythruunClasses)
	var i = 0
	for yc in ythruunClasses:
		var y = yc.instance()
		y.position = Vector2((i % 4) * 8192.0 - 12288.0 + randf() * 6144.0 - 3072.0, (i / 4) * 8192.0 - 12288.0 + randf() * 6144.0 - 3072.0) / 2.0
		$YthruunNode.add_child(y)
		i += 1
	star = starClass.instance()
	add_child(star)
	set_process_input(true)
	set_physics_process(true)

func shuffleList(list):
	var result = []
	while list.size() > 0:
		var i = randi() % list.size()
		result.append(list[i])
		list.remove(i)
	return result

func addEffect(p):
	var e = effectClass.instance()
	e.position = p
	$Effect.add_child(e)

func _input(event):
	if event.is_action("escape"):
		get_tree().quit()
	star.checkInput(event)

func _physics_process(delta):
	star.update(delta)
	$Particles.position = get_global_mouse_position()