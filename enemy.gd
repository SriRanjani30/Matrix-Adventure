extends CharacterBody2D

@export var speed: float = 50
@export var left_limit: float = -100
@export var right_limit: float = 100
@export var attack_cooldown: float = 1.0  # seconds between attacks

var direction := -1
var start_position := Vector2.ZERO
var can_attack := true
var player_in_range := false
var target_player: Node = null

func _ready():
	start_position = global_position
	$AnimatedSprite2D.play("run")  # Start running

func _physics_process(delta):
	# Patrol only if no player nearby
	if !player_in_range:
		global_position.x += direction * speed * delta

		var distance_from_start = global_position.x - start_position.x
		if distance_from_start < left_limit:
			direction = 1
			$AnimatedSprite2D.flip_h = false
		elif distance_from_start > right_limit:
			direction = -1
			$AnimatedSprite2D.flip_h = true

func _on_attack_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		target_player = body

		# Face the player
		if target_player.global_position.x < global_position.x:
			direction = -1
			$AnimatedSprite2D.flip_h = true
		else:
			direction = 1
			$AnimatedSprite2D.flip_h = false

		$AnimatedSprite2D.play("attack")
		attack_player()


func _on_attack_area_body_exited(body: Node2D) -> void:
	if body == target_player:
		player_in_range = false
		target_player = null
		$AnimatedSprite2D.play("run")

func attack_player():
	if can_attack and target_player:
		# Always face player before attack
		if target_player.global_position.x < global_position.x:
			direction = -1
			$AnimatedSprite2D.flip_h = true
		else:
			direction = 1
			$AnimatedSprite2D.flip_h = false

		if target_player.has_method("take_damage"):
			target_player.take_damage(1)

		can_attack = false
		await get_tree().create_timer(attack_cooldown).timeout
		can_attack = true

		# If still close after cooldown, attack again
		if player_in_range:
			attack_player()
