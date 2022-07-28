extends Button

export(PackedScene) var target_scene
func _ready():
	$".".connect("pressed", self, "change_scene")

func change_scene():
	print('Retry?')
	var ERR = get_tree().change_scene_to(target_scene)
	GlobalScript.coins = 0
	GlobalScript.health = 10
