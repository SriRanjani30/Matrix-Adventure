extends CharacterBody2D

@export var speed := 300
@export var jump_velocity := -600
var gravity := 700

@onready var sprite := $AnimatedSprite2D

var can_climb = false
var is_climbing = false

const CLIMB_SPEED = 350

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

	# Move the character
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

	# Jump if on floor and input is pressed
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_velocity

var health := 5

func take_damage(amount: int):
	health -= amount
	print("Player Health:", health)
	if health <= 0:
		die()

func die():
	print("Player has died")
	queue_free()  # or trigger game over
