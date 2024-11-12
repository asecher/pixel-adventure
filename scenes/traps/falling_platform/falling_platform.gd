extends AnimatableBody2D
class_name FallingPlatform

@onready var starting_delay: Timer = $StartingDelay
@onready var falling_timer: Timer = $FallingTimer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D

@export var delay := .1

var down: bool
var velocity: Vector2
var original_position: Vector2
var offset: Vector2
var stepped = false
var is_falling = false

const SPEED := 65
const AMPLITUDE := 3
const SPEED_STEPPED := 500
const AMPLITUDE_STEPPED := 6
const SPEED_FALLING := 650

func _ready() -> void:
	starting_delay.wait_time = delay
	down = true
	velocity = Vector2.ZERO
	original_position = position
	offset = original_position + Vector2.DOWN * AMPLITUDE
	starting_delay.start()

func _physics_process(delta: float) -> void:
	if not starting_delay.is_stopped(): 
		return
		
	if not is_falling:
		var speed = SPEED if not stepped else SPEED_STEPPED
		
		var dir = Vector2.DOWN if down else Vector2.UP
		velocity.y += delta * speed * dir.y
		position.y += velocity.y * delta
		
		if down and position.y >= offset.y:
			down = false
			velocity = Vector2.ZERO
		elif not down and position.y <= original_position.y:
			down = true
			velocity = Vector2.ZERO
	else:
		position.y += Vector2.DOWN.y * SPEED_FALLING * delta

func activate() -> void:
	if stepped: 
		return
		
	stepped = true
	offset = original_position + Vector2.DOWN * AMPLITUDE_STEPPED
	falling_timer.start()


func _on_falling_timer_timeout() -> void:
	animated_sprite_2d.play("off")
	is_falling = true
	gpu_particles_2d.emitting = false



func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
