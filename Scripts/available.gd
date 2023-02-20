extends Spatial


export (Dictionary) var active


func _enter_tree():
	var main: Node = get_tree().root.get_node("Control/Main")
	
	main.set_active(active)
	
	var spawnpoints: Array = []
	for s in get_children():
		if s.is_in_group("spawnpoint"):
			spawnpoints.append(s)
	
	main.add_spawnpoints(spawnpoints)
