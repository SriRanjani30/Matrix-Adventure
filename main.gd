extends Node2D

@onready var spawn_point = $SpawnPoint

func _ready():
	var scene_path = ""

	match Global.selected_character:
		"girl":
			scene_path = "res://Characters/girl.tscn"
		"boy":
			scene_path = "res://Characters/boy.tscn"
		"robot":
			scene_path = "res://Characters/robot.tscn"

	if scene_path != "":
		var character_scene = load(scene_path)
		var character_instance = character_scene.instantiate()
		character_instance.position = spawn_point.position
		add_child(character_instance)
