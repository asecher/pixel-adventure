extends Camera2D

# The starting range of possible offsets using random values
@export var RANDOM_SHAKE_STRENGTH: float = 2.0
# Multiplier for lerping the shake strength to zero
@export var SHAKE_DECAY_RATE: float = 8.0

@onready var rand = RandomNumberGenerator.new()

var shake_strength: float = 0.0

func _ready() -> void:
	rand.randomize()

func _process(delta: float) -> void:
	shake_strength = lerp(shake_strength, 0.0, SHAKE_DECAY_RATE * delta)
	
	offset = Vector2(
		rand.randf_range(-shake_strength, shake_strength),
		rand.randf_range(-shake_strength, shake_strength)
	)
	
func apply_shake() -> void:
	shake_strength = RANDOM_SHAKE_STRENGTH
