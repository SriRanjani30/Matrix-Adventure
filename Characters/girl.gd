extends CharacterBody2D

@export var speed := 300
@export var jump_velocity := -600
var gravity := 700

@onready var sprite := $AnimatedSprite2D
@onready var camera := $Camera2D 

var can_climb = false
var is_climbing = false
const CLIMB_SPEED = 350

var max_health := 5
var health := 5
var hud = null 

func _physics_process(delta):
	var direction = Input.get_axis("left", "right")
	velocity.x = direction * speed

	if can_climb:
		if Input.is_action_pressed("climb_up"):
			velocity.y = -CLIMB_SPEED
			is_climbing = true
		elif Input.is_action_pressed("climb_down"):
			velocity.y = CLIMB_SPEED
			is_climbing = true
		else:
			if is_climbing:
				velocity.y = 0
	else:
		is_climbing = false
		velocity.y += gravity * delta

	move_and_slide()

	# Flip sprite
	if direction != 0:
		sprite.flip_h = direction < 0

	# Play animations
	if not is_on_floor():
		sprite.play("jump")
	elif direction != 0:
		sprite.play("run")
	else:
		sprite.play("idle")

	# Jump
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_velocity


func take_damage(amount: int):
	health -= amount
	if health < 0:
		health = 0

	print("Player Health:", health)

	# 🔹 Update HUD
	if hud:
		hud.set_health(health)

	# Red flash effect
	var original_modulate = sprite.modulate
	sprite.modulate = Color(1, 0, 0)
	await get_tree().create_timer(0.1).timeout
	sprite.modulate = original_modulate

	# Camera shake
	if camera:
		camera_shake(4, 0.02, 5)

	if health <= 0:
		die()


func die():
	print("Player has died")
	var gm = get_tree().get_root().get_node("Main/GameManager")
	if gm:
		gm.game_over()
	queue_free()


func camera_shake(strength: float, delay: float, times: int):
	var original_offset = camera.offset
	for i in range(times):
		camera.offset = original_offset + Vector2(randf_range(-strength, strength), randf_range(-strength, strength))
		await get_tree().create_timer(delay).timeout
	camera.offset = original_offset
