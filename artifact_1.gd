extends Area2D

func _ready():
	if has_node("Sprite2D"):
		$Sprite2D.z_index = 10
	
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.is_in_group("player"):
		win_game()

func win_game():
	# Pause the game
	get_tree().paused = true

	# Get the existing win node
	var win_node = get_tree().get_root().get_node("Main/UILayer/win")
	if win_node:
		win_node.visible = true
		win_node.set_z_as_relative(false)
		win_node.z_index = 1000
