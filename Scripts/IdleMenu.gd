extends Control


export (float) var idle_time = 120.0


func _input(event):
	visible = false
	$"../Menu".visible = true
	
	$Timer.stop()
	$Timer.start(idle_time)


func _timer_timeout():
	visible = true
	$"../Menu".visible = false
	$"../Menu"._on_Clear()
