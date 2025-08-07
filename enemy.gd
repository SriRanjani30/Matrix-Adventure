extends CharacterBody2D

@export var speed: float = 50
@export var left_limit: float = -100
@export var right_limit: float = 100
@export var attack_cooldown: float = 1.0  # seconds between attacks

var direction := -1
var start_position := Vector2.ZERO
var can_attack := true
var player_in_range := false  # optional, to handle idle/walk switching

func _ready():
	start_position = global_position
	$AnimatedSprite2D.play("walk")  # Start with walk or idle

func _physics_process(delta):
	# Only patrol if not attacking
	if !player_in_range:
		var displacement = direction * speed * delta
		global_position.x += displacement

		var distance_from_start = global_position.x - start_position.x
		if distance_from_start < left_limit:
			direction = 1
			$AnimatedSprite2D.flip_h = false
		elif distance_from_start > right_limit:
			direction = -1
			$AnimatedSprite2D.flip_h = true

func _on_attack_area_body_entered(body: Node2D) -> void:
	if body.name == "Player" and can_attack:
		player_in_range = true
		$AnimatedSprite2D.play("attack")
		
		if body.has_method("take_damage"):
			body.take_damage(1)
		
		can_attack = false
		# Start cooldown without blocking
		attack_cooldown_timer()

func _on_attack_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = false
		$AnimatedSprite2D.play("walk")

func attack_cooldown_timer():
	await get_tree().create_timer(attack_cooldown).timeout
	can_attack = true
	# If player is still in range, attack again
	if player_in_range:
		_on_attack_area_body_entered(get_node("/root/Player"))  # Or use signal system for safety
