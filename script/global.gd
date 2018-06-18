extends Node

func setScene(path):
	call_deferred("deferredSetScene", path)
	
func deferredSetScene(path):
	var root = get_tree().get_root()
	root.get_child(root.get_child_count() - 1).free()
	var sceneClass = load(path)
	var scene = sceneClass.instance()
	root.add_child(scene)
	get_tree().set_current_scene(scene)