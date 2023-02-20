extends Control


export (Array, String) var ignore_base_switch
export (Dictionary) var active
var first_active_copy: Dictionary = active
var base_spawned: bool = false


func _ready() -> void:
	init_buttons()
	first_active_copy = active


func init_buttons() -> void:
	for c in get_children():
		if c.is_in_group("spawn_button"):
			c.disabled = !active.has(c.name)


func _on_spawn_pressed(which: String) -> void:
	$"../Main".spawn_flake(active[which], !base_spawned)
	if not which in ignore_base_switch:
		base_spawned = true
	else:
		for b in ignore_base_switch:
			get_node(b).disabled = true


func _on_Clear() -> void:
	$"../Main".clear_all()
	active = first_active_copy
	init_buttons()
	base_spawned = false
