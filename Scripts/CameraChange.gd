extends Area2D

export var x_pos : int
export var zoom_x : float

func _ready():
	print(get_node("Camera2D").offset.x)

func _on_Area2D_body_entered(body):
	if body.name == 'Player':
		get_node("Camera2D").offset.x = x_pos
		get_node("Camera2D").zoom.x = zoom_x
		get_node("Camera2D").current = true
		print('nice')
