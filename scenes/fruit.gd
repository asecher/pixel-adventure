extends Area2D

@export var fruit_type: Fruit

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animated_sprite_2d.sprite_frames = fruit_type.frames
	animated_sprite_2d.play("default")

func _on_body_entered(body: Node2D) -> void:
	animation_player.play("pickup")
	GameManager.increment_score()