extends Node

@onready var hud = $HUD   # Your HUD instance inside the GameManager scene

func game_over():
	if hud:
		hud.show_message("GAME OVER", Color.RED)
	get_tree().paused = true

func you_win():
	if hud:
		hud.show_message("YOU WIN!", Color.GREEN)
	get_tree().paused = true
