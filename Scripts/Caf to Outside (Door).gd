extends Area2D

export (String, FILE, "*.tscn, *.scn") var scene
export var overlappingbodies : int

func _input(event):
	if get_overlapping_bodies().size() > overlappingbodies and event.is_action_pressed("ui_accept"):
		get_tree().change_scene(scene)
