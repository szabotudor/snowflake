extends Spatial


export var rotation_speed: float = 0.4
export var num_idle_frame_return: int = 15
var spawners = []
var num_flakes_spawned: int = 0
var now_spawning: bool = false


func _ready():
	spawners = get_spawners_from_node(self)


func _process(delta):
	$CamContainer.rotate_y(rotation_speed * delta)


func get_spawners_from_node(n: Node) -> Array:
# warning-ignore:shadowed_variable
	var spawners = []
	for c in n.get_children():
		if c.is_in_group("spawner"):
			spawners.append(c)
	return spawners


func get_flakes_from_node(n: Node) -> Array:
# warning-ignore:shadowed_variable
	var spawners = []
	for c in n.get_children():
		if c.is_in_group("flake"):
			spawners.append(c)
	return spawners


func load_scene(var path) -> Node:
	var result : Node = null
	if ResourceLoader.exists(path):
		result = ResourceLoader.load(path).instance()
	return result


func add_flake(flake):
	if num_flakes_spawned > 3:
		for c in $"../Menu".get_children():
			if c.is_in_group("spawn_button"):
				c.disabled = true
		return
	$"../Menu/Clear".disabled = true
	now_spawning = true;
	num_flakes_spawned += 1
	print("Spawning flake: ", flake)
	var node = load_scene(flake)
	var spawners_temp = []
	var ifn = 0
	for s in spawners:
		var temp = node.duplicate()
		s.add_child(temp)
		temp.add_to_group("flake")
		spawners_temp += get_spawners_from_node(temp)
		if ifn >= num_idle_frame_return:
			yield(get_tree(), "idle_frame")
			ifn = 0
		ifn += 1
	spawners = spawners_temp
	now_spawning = false
	$"../Menu/Clear".disabled = false


func clear():
	print("Clearing flake")
	for s in spawners:
		for f in get_flakes_from_node(s):
			f.queue_free();
	for c in $"../Menu".get_children():
		if c.is_in_group("spawn_button"):
			c.disabled = false
	num_flakes_spawned = 0
	spawners = get_spawners_from_node(self)
