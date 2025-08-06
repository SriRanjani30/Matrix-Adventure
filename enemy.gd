extends CharacterBody2D

@export var speed: float = 50
@export var left_limit: float = -100
@export var right_limit: float = 100

var direction := -1
var start_position := Vector2.ZERO

func _ready():
	start_position = global_position

func _physics_process(delta):
	var displacement = direction * speed * delta
	global_position.x += displacement

	# Check limits
	var distance_from_start = global_position.x - start_position.x
	if distance_from_start < left_limit:
		direction = 1
	elif distance_from_start > right_limit:
		direction = -1


func _on_attack_area_body_entered(body: Node2D) -> void:
	pass # Replace with function body.


func _on_attack_area_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
