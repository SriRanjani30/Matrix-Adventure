extends Node2D

@export var enemy_scene: PackedScene  # Drag your enemy.tscn here in the Inspector

func _ready():
	# Loop through all Marker2D children and spawn enemies
	for child in get_children():
		if child is Marker2D:
			spawn_enemy_at(child.global_position)

func spawn_enemy_at(position: Vector2):
	var enemy = enemy_scene.instantiate()
	enemy.global_position = position
	get_tree().get_current_scene().add_child(enemy)
