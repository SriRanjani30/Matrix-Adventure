extends Control

func _on_button_girl_pressed():
	Global.selected_character = "girl"
	Global.selected_character_scene_path = "res://Characters/girl.tscn"
	get_tree().change_scene_to_file("res://main.tscn")

func _on_button_boy_pressed():
	print("Boy button pressed")
	Global.selected_character = "boy"
	Global.selected_character_scene_path = "res://Characters/boy.tscn"
	get_tree().change_scene_to_file("res://main.tscn")

func _on_button_robot_pressed():
	Global.selected_character = "robot"
	Global.selected_character_scene_path = "res://Characters/robot.tscn"
	get_tree().change_scene_to_file("res://main.tscn")
