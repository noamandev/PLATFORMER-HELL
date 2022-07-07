extends Button

export(String, FILE, "*.tscn, *.scn") var target_scene
func _ready():
	$".".connect("pressed", self, "change_scene")

func change_scene():
	var ERR = get_tree().change_scene(target_scene)
	GlobalScript.coins = 0
	GlobalScript.health = 10
