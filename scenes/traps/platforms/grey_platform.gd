extends Path2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatableBody2D/AnimatedSprite2D
@onready var path_follow_2d: PathFollow2D = $PathFollow2D
@onready var chains: Node2D = $Chains

const CHAIN = preload("res://scenes/traps/platforms/platform_chain.tscn")

var direction := 1.0

func _ready() -> void:
	for i in curve.point_count:
		var chain = CHAIN.instantiate()
		chains.add_child(chain)
		chain.position = curve.get_point_position(i)

func _process(delta: float) -> void:
	path_follow_2d.progress = path_follow_2d.progress + delta * 60 * direction
	if path_follow_2d.progress_ratio == 0 or path_follow_2d.progress_ratio==1:
		direction *= -1
