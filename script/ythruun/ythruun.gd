extends Node2D

var panelClass = preload("res://scene/panel.tscn")
var panelPos = [Vector2(0.0, -768.0), Vector2(0.0, -512.0), Vector2(0.0, -256.0), Vector2(0.0, 0.0), 
				Vector2(0.0, 256.0), Vector2(0.0, 512.0), Vector2(0.0, 768.0), Vector2(0.0, 1024.0), 
				Vector2(-256.0, 768.0), Vector2(-512.0, 768.0), Vector2(-768.0, 768.0), Vector2(-256.0, -512.0), 
				Vector2(-512.0, -512.0), Vector2(-256.0, 0.0), Vector2(256.0, 0.0), Vector2(512.0, -256.0), 
				Vector2(768.0, -256.0), Vector2(1024.0, -512.0), Vector2(512.0, 512.0)]

func _ready():
	for p in panelPos:
		var panel = panelClass.instance()
		panel.position = p
		add_child(panel)

func checkDead():
	if get_child_count() == 1:
		get_node("../..").star.gainHeat(4.0)
		queue_free()