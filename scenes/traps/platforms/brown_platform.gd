extends Path2D
class_name BrownPlatform

@onready var path_follow_2d: PathFollow2D = $PathFollow2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatableBody2D/AnimatedSprite2D
@onready var chains: Node2D = $Chains
@onready var animatable_body_2d: AnimatableBody2D = $AnimatableBody2D

const CHAIN = preload("res://scenes/traps/platforms/platform_chain.tscn")

var has_riders = false
var direction

func _ready() -> void:
	for i in curve.point_count:
		var chain = CHAIN.instantiate()
		chains.add_child(chain)
		chain.position = curve.get_point_position(i)

func _physics_process(delta: float) -> void:
	direction = 1 if has_riders else -1
		
	if has_riders:
		animated_sprite_2d.play("on")
	
	path_follow_2d.progress  = path_follow_2d.progress + delta * 60 * direction
	if (direction == 1 and path_follow_2d.progress_ratio == 1.0) or\
		(direction == -1 and path_follow_2d.progress_ratio == 0.0):
		animated_sprite_2d.play("off")


func _on_player_area_body_exited(body: Node2D) -> void:
	has_riders = false
