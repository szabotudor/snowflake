extends Spatial


export var rotation_speed: float = 0.4
export var num_idle_frame_return: int = 15
var spawners = []
var num_flakes_spawned: int = 0
var now_spawning: bool = false

onready var spawner_nodes: Array = [self]
var temp_spawner_nodes: Array = []


func _input(event):
	if Input.is_action_pressed("tap") and event is InputEventMouseMotion:
		$CamContainer.rotate_y(deg2rad(-event.relative.x * rotation_speed))


func load_scene(var path) -> Node:
	var result : Node = null
	if ResourceLoader.exists(path):
		result = ResourceLoader.load(path).instance()
	return result


func set_active(active: Dictionary) -> void:
	$"../Menu".active = active
	$"../Menu".init_buttons()


func clear_spawnpoints() -> void:
	spawner_nodes = []
	temp_spawner_nodes = []
func add_spawnpoints(spawnpoints: Array) -> void:
	temp_spawner_nodes += spawnpoints


func spawn_flake(flake: String, as_base: bool) -> void:
	var f: Node
	if as_base:
		f = load_scene("res://Modele/import/baza-" + flake + ".tscn") 
	else:
		f = load_scene("res://Modele/import/ramura-" + flake + ".tscn")
	

	for s in spawner_nodes:
		s.add_child(f.duplicate())
	spawner_nodes = temp_spawner_nodes
	temp_spawner_nodes = []


func clear_all() -> void:
	clear_spawnpoints()
	
	for c in get_children():
		if c.is_in_group("base"):
			c.queue_free()
	
	spawner_nodes = [self]
