extends Control


export (Array, String) var flake_file_list = []


func _ready():
	pass


func _on_spawn_pressed(which):
	if $"../Main".now_spawning:
		return
	print("Attempting to spawn flake with index: ", which)
	if which < flake_file_list.size():
		print("Doing spawn: ")
		$"../Main".add_flake(flake_file_list[which])
	else:
		print("Index out of range: did you forget to add a flake file path to list?")


func _on_Clear():
	$"../Main".clear()
	yield(get_tree(), "idle_frame")
	$"../Main".clear()
