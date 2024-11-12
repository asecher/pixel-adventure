extends CharacterBody2D
class_name Player

const DEFAULT_FRICTION := 10 
const FRICTION_ON_ICE := 4
var friction := DEFAULT_FRICTION

const SPEED := 250.0
const JUMP_VELOCITY := -700.0
const WALL_JUMP_PUSHBACK := 245
const WALL_SLIDE_FRICTION := 40
var is_wall_sliding := false

const MAX_JUMPS := 2
var current_jumps := 1

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	GameManager.player = self

func _physics_process(delta: float) -> void:
	# Add the gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
		if not is_wall_sliding:
			if velocity.y > 0: 
				animated_sprite_2d.play("fall")
			else:
				if current_jumps == 2:
					animated_sprite_2d.play("double_jump")
				else:
					animated_sprite_2d.play("jump")
	else:
		if velocity.x > 1 or velocity.x < -1:
			animated_sprite_2d.play("run")
		else:
			animated_sprite_2d.play("idle")

	var direction := Input.get_axis("ui_left", "ui_right")

	# Get the input direction and handle the movement/deceleration.
	if direction:
		velocity.x = direction * SPEED
		if direction == -1:
			animated_sprite_2d.flip_h = true
		else:
			animated_sprite_2d.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, friction)
	
	move_and_slide()
	handle_collisions()
	
	# Handle wall slide
	if is_on_wall() and not is_on_floor() and velocity.y > 0:
		is_wall_sliding = true
		animated_sprite_2d.play("wall_jump")
		
	else:
		is_wall_sliding = false
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_up"):
		if current_jumps < MAX_JUMPS:
			velocity.y = JUMP_VELOCITY
			current_jumps += 1
			if is_wall_sliding:
				if animated_sprite_2d.flip_h == true: 
					print("+WALL_JUMP_PUSHBACK")
					velocity.x = WALL_JUMP_PUSHBACK
				elif animated_sprite_2d.flip_h == false:
					print("-WALL_JUMP_PUSHBACK")
					velocity.x = -WALL_JUMP_PUSHBACK 
	
	if is_on_floor() or is_on_wall():
		current_jumps = 1
	
	if is_wall_sliding:
		velocity.y += (WALL_SLIDE_FRICTION * delta)
		velocity.y = min(velocity.y, WALL_SLIDE_FRICTION)

func launch(v: Vector2) -> void:
	velocity = v
	
func handle_collisions() -> void:
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		var normal = collision.get_normal()
		
		if collider is Trampoline and normal.y == -1:
			collider.activate(self)
			break
		
		if collider is FallingPlatform:
			if normal.y == -1:
				collider.activate()
		elif collider is AnimatableBody2D and collider.get_parent() is BrownPlatform and normal.y == -1:
			var platform = collider.get_parent()
			platform.has_riders = true
