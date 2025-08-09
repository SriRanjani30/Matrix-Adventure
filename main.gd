extends Node2D

@onready var hud = $GameManager/HUD
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

	var player = load(scene_path).instantiate()
	add_child(player)
	player.global_position = spawn_point.global_position

	# Give the player a reference to the HUD
	player.hud = hud
