extends Node2D

@export var artifact_scene: PackedScene

func _ready():
	# Collect only Marker2D children manually
	var markers: Array[Marker2D] = []
	for child in get_children():
		if child is Marker2D:
			markers.append(child)

	# Pick a random one
	if markers.size() > 0 and artifact_scene:
		var random_marker = markers[randi() % markers.size()]
		spawn_artifact_at(random_marker.global_position)

func spawn_artifact_at(target_position: Vector2):
	var artifact_instance = artifact_scene.instantiate()
	artifact_instance.position = target_position
	get_tree().get_current_scene().add_child.call_deferred(artifact_instance)
