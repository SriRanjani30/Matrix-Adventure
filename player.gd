extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D

const SPEED = 200
const JUMP_FORCE = -400
const GRAVITY = 1000.0

func _physics_process(delta):
	var direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = direction * SPEED

	# Apply gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Jumping
	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_FORCE

	# Move the character
	move_and_slide()

	# Flip sprite depending on direction
	if direction != 0:
		sprite.flip_h = direction < 0

	# Play appropriate animation
	if not is_on_floor():
		sprite.play("jump")
	elif direction != 0:
		sprite.play("run")
	else:
		sprite.play("idle")
