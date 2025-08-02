extends CharacterBody2D

@export var speed := 200
@export var jump_velocity := -400
var gravity := 700

@onready var sprite := $AnimatedSprite2D

func _physics_process(delta):
	var direction = Input.get_axis("left", "right")
	velocity.x = direction * speed

	# Flip sprite based on direction
	if direction != 0:
		sprite.flip_h = direction < 0

	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_velocity

	# Play animations
	if not is_on_floor():
		sprite.play("jump")
	elif direction != 0:
		sprite.play("run")
	else:
		sprite.play("idle")

	move_and_slide()
